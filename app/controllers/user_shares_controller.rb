class UserSharesController < ApplicationController
  # user_id: nil, review_id: nil, link_id: nil, active: true

  def get_user_share
    ## expected params ####
    # user_share: {
        # :id
    # }

    user_share_id_from_params = strong_get_user_share_params[:id]

    @user_share = UserShare.find_by(id: user_share_id_from_params)

    if !@user_share
      render json: {status: "failure", action: "get_user_share", details: "user_share not found (by id)"}, status: 200
      return
    end

    serialized_user_share = {id: @user_share.id, user: @user_share.user.username, date: @user_share.updated_at, tags: @user_share.tags, review: {id: @user_share.review.id ,reviewer: @user_share.review.reviewer.username, content: @user_share.review.content, rating: @user_share.review.rating, review_comments: @user_share.review.review_comments}, link: @user_share.link}

    render json: {status: "success", action: "get_user_share", user_share: serialized_user_share}, status: 200
  end

  def all_user_shares_for_link
    ## expected params ####
    # link: {
        # :id
    # }

    link_id_from_params = strong_all_user_shares_for_link_params[:id]
    @link = Link.find(link_id_from_params)

    if !@link
      render json: {status: "failure", action: "all_user_shares_for_link", details: "link not found (by id)"}, status: 200
      return
    end

    serialized_user_shares = []

    @link.user_shares.each do |u_s|
      to_go = {id: u_s.id, user: u_s.user.username, review: {id: u_s.review.id ,reviewer: u_s.review.reviewer.username, content: u_s.review.content, rating: u_s.review.rating, review_comments: u_s.review.review_comments}, link: u_s.link}
      serialized_user_shares.push(to_go)
    end

    render json: {status: "success", action: "all_user_shares_for_link", link: @link, user_shares: serialized_user_shares}, status: 200
  end

  def construct_user_share
    ## expected params ####
    # user_share: {
        # :token,
        # :review_information => {:content, :rating},
        # :link_information => {:url},
        # :tags => [...tags]
    # }

    ## link-related ##
    link_url_from_params = strong_construct_user_share_params[:link_information][:url]

    ## tag-related ##
    tags_from_params = strong_construct_user_share_params[:tags]

    ## review-related ##
    review_content_from_params = strong_construct_user_share_params[:review_information][:content]
    review_rating_from_params = strong_construct_user_share_params[:review_information][:rating]

    ## user-related ##
    token_from_params = strong_construct_user_share_params[:token]
    user_id = get_user_id_from_token(token_from_params)

    #########################################

    # have to produce X.new & instance.valid? for every one of the models to be made,
    # so that all logic happens together if correct
    # or no logic happens at all if any error
     # if all of them are valid move forward,
     # else send back a detailed errors list for use in updating form

     if !(link_url_from_params.include?("http"))
       link_url_from_params = "https://" + link_url_from_params
     else
       if !(link_url_from_params.include?("https"))
         # split it at "//"
         b = link_url_from_params.split("://")[1]
         link_url_from_params = "https://" + b
       end
     end

     if link_url_from_params.include?("www.")
       link_url_from_params = link_url_from_params.split("www.").join("")
     end

    temp_link = Link.new(url: link_url_from_params)
    temp_review = Review.new(reviewer_id: user_id, content: review_content_from_params, rating: review_rating_from_params)

    # load the instances up with errors (if any).
    # since the following if statement may not populate all errors due to nature of an || statement

    temp_link.valid?
    temp_review.valid?

    if !temp_link.valid? ||
      tags_from_params.length == 0 ||
      !temp_review.valid?
      render json: {status: "failure", action: "construct_user_share", link_errors: temp_link.errors.full_messages, review_errors: temp_review.errors.full_messages, token: token_from_params}, status: 200
      return
    end

    #########################################


    # if link not in database, persist the link in the database
    @link = Link.find_or_create_by(url: link_url_from_params)

    # persist link-tag-joins in the database
    # only if link_tag_join doesn't already exists
    tags_from_params.each do |tag|
      @tag = Tag.find_by(title: tag)

      if !LinkTagJoin.find_by(link_id: @link.id, tag_id: @tag.id)
        LinkTagJoin.create(tag_id: @tag.id, link_id: @link.id)
      end
    end

    # persist the review in the database
    @review = Review.create(reviewer_id: user_id, link_id: @link.id, content: review_content_from_params, rating: review_rating_from_params)

    # persist the use-share in the database
    @user_share = UserShare.create(user_id: user_id, link_id: @link.id, review_id: @review.id)

    # update review and any others with user-share
    @review.user_share_id = @user_share.id
    @review.save

    tags_from_params.each do |tag|
      @tag = Tag.find_by(title: tag)

      UserShareTagJoin.create(tag_id: @tag.id, user_share_id: @user_share.id)
    end


    render json: {status: "success", action: "construct_user_share", user_share_id: @user_share.id, token: token_from_params}, status: 200
  end

  def update_user_share
    ## expected params ##
    # user_share: {
        # :id,
        # :token,
        # :review_information => {:content, :rating},
        # :link_information => {:url},
        # :tags => [...tags]
    # }

    ## user_share -related ##
    user_share_id_from_params = strong_update_user_share_params[:id]

    ## link-related ##
    link_url_from_params = strong_update_user_share_params[:link_information][:url]

    ## tag-related ##
    tags_from_params = strong_update_user_share_params[:tags]

    ## review-related ##
    review_content_from_params = strong_update_user_share_params[:review_information][:content]
    review_rating_from_params = strong_update_user_share_params[:review_information][:rating]

    ## user-related ##
    token_from_params = strong_update_user_share_params[:token]
    user_id = get_user_id_from_token(token_from_params)

    #########################################

    # have to produce X.new & instance.valid? for every one of the models to be made,
    # so that all logic happens together if correct
    # or no logic happens at all if any error
     # if all of them are valid move forward,
     # else send back a detailed errors list for use in updating form


    if !(link_url_from_params.include?("http"))
      link_url_from_params = "https://" + link_url_from_params
    else
      if !(link_url_from_params.include?("https"))
        # split it at "//"
        b = link_url_from_params.split("://")[1]
        link_url_from_params = "https://" + b
      end
    end

    temp_link = Link.new(url: link_url_from_params)
    temp_review = Review.new(reviewer_id: user_id, content: review_content_from_params, rating: review_rating_from_params)

    # load the instances up with errors (if any).
    # since the following if statement may not populate all errors due to nature of an || statement

    temp_link.valid?
    temp_review.valid?

    if !temp_link.valid? ||
      tags_from_params.length == 0 ||
      !temp_review.valid?
      render json: {status: "failure", action: "update_user_share", link_errors: temp_link.errors.full_messages, review_errors: temp_review.errors.full_messages, token: token_from_params}, status: 200
      return
    end

    #########################################

    @user_share = UserShare.find_by(id: user_share_id_from_params)

    # update user_share_tag_joins
    @user_share.user_share_tag_joins.each do |u_s_t_j|
      u_s_t_j.destroy
    end

    tags_from_params.each do |tag_title|
      tag = Tag.find_by(title: tag_title)
      UserShareTagJoin.create(user_share_id: @user_share.id,tag_id: tag.id)
    end

    # update the review
    @review = @user_share.review
    @review.update(content: review_content_from_params, rating: review_rating_from_params)


    # update link (and link_tag_joins)
    @old_link = @user_share.link
    if @old_link.user_shares.length == 1
      # only user_share associated with this link
      # update link itself
      # update link-tag-joins
      @old_link.update(url: link_url_from_params)

      @old_link.link_tag_joins.each do |ltj|
        ltj.destroy
      end

      tags_from_params.each do |tag_title|
        # find the tag to use its id
        # construct ltj
        tag = Tag.find_by(title: tag_title)
        LinkTagJoin.create(link_id: @link.id, tag_id: tag.id)
      end



      render json: {status: "success", action: "update_user_share", user_share_id: @user_share.id}, status: 200
    else
      # not only user_share associated with this link
      # go through all user_shares associated with this link EXCEPT THIS USER_SHARE
        # gather all tag IDs
        # make these tag IDs be only tag IDs connected to the original link

      other_user_shares_of_old_link = []

      @old_link.user_shares.each do |u_s|
        if u_s.id != @user_share.id
          other_user_shares_of_old_link << u_s
        end
      end

      tag_ids_for_old_link = []

      other_user_shares_of_old_link.each do |u_s|
        u_s.tags.each do |tag|
          tag_ids_for_old_link << tag.id
        end
      end

      @old_link.link_tag_joins.each do |l_t_j|
        l_t_j.destroy
      end

      # unique tags_for_old_link
      unique_tag_ids_for_old_link = tag_ids_for_old_link.uniq

      if @old_link.url != link_url_from_params

        unique_tag_ids_for_old_link.each do |tagID|
          tag = Tag.find(tagID)
          LinkTagJoin.create(tag_id: tag.id, link_id: @old_link.id)
        end

        # construct new link
        # with all link_tag_joins given tag ids in params
        # need to update review's link_id to @new_link.id
        # need to update user_share's link_id to @new_link.id
        # also user_share_tag_joins

        @new_link = Link.create(url: link_url_from_params)

        # connect with tags in params
        tags_from_params.each do |tag_title|
          tag = Tag.find_by(title: tag_title)
          LinkTagJoin.create(link_id: @new_link.id, tag_id: tag.id)
        end

        # need to update user_share's link_id to @new_link.id
        @user_share.update(link_id: @new_link.id)

        # update review's link_id to @new_link.id
        @review.update(link_id: @new_link.id)

      else
        # add tags from params as LinkTagJoins with @old_link & the tag_id
        tags_from_params.each do |tag_title|
          tag = Tag.find_by(title: tag_title)
          unique_tag_ids_for_old_link << tag.id
        end

        unique_tag_ids_for_old_link.uniq!
        unique_tag_ids_for_old_link.each do |tagID|
          tag = Tag.find(tagID)
          LinkTagJoin.create(tag_id: tag.id, link_id: @old_link.id)
        end

        # no need to update user_share's link_id or review's link_id
      end


      #render success
      render json: {status: "success", action: "update_user_share", user_share_id: @user_share.id}, status: 200
    end

  end

  def destroy_user_share
    ## expected params ####
    # user_share: {
        # :id
    # }

    user_share_id_from_params = strong_destroy_user_share_params[:id]

    @user_share = UserShare.find(user_share_id_from_params)

    if !@user_share
      render json: {status: "failure", action: "destroy_user_share", details: "user_share not found (by id)"}, status: 200
      return
    end

    # destroy/deactivate user_share-associated items
    # link if this only user_share with link
    if @user_share.link.user_shares.length == 1
      @link_tag_join = LinkTagJoin.find(@user_share.link.user_shares.first.id)

      @link_tag_join.destroy

      @user_share.link.destroy
    end

    # review and review-comments (see users_controller#destroy)
    @user_share.review.review_comments.each do |review_comment|
      review_comment.destroy
    end

    @user_share.review.destroy

    # destroy user_share
    @user_share.destroy

    render json: {status: "success", action: "destroy_user_share", user_share: @user_share, link_tag_join: @link_tag_join, review: @user_share.review, review_comments: @user_share.review.review_comments}, status: 200
  end

  private
  #### params-related ####
  def strong_get_user_share_params
    params.require(:user_share).permit(:id)
  end

  def strong_all_user_shares_for_link_params
    params.require(:link).permit(:id)
  end

  def strong_construct_user_share_params
    params.require(:user_share).permit(:token, :review_information => [:content, :rating], :link_information => [:url], tags: [])
  end

  def strong_destroy_user_share_params
    params.require(:user_share).permit(:id)
  end

  def strong_update_user_share_params
    params.require(:user_share).permit(:id, :token, :review_information => [:content, :rating], :link_information => [:url], tags: [])
  end

  #### helper functions ####
  def get_user_id_from_token(token)
    secret = "secret"
    # decode payload: [{user_id: user.id}, {alg...}]
    payload = JWT.decode(token,secret, "HS256")
    # find user
    payload[0]["user_id"]
  end

end
