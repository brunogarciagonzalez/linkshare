class UserSharesController < ApplicationController
  # user_id: nil, review_id: nil, link_id: nil, active: true

  def get_user_share
    ## expected params ####
    # user_share: {
        # :id
    # }

    user_share_id_from_params = strong_get_user_share_params[:id]

    @user_share = UserShare.find(user_share_id_from_params)

    if !@user_share
      render json: {status: "failure", action: "get_user_share", details: "user_share not found (by id)"}, status: 200
      return
    end

    serialized_user_share = {id: @user_share.id, user: @user_share.user.username, review: {id: @user_share.review.id ,reviewer: @user_share.review.reviewer.username, content: @user_share.review.content, rating: @user_share.review.rating, review_comments: @user_share.review.review_comments}, link: @user_share.link}

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
        # :review_information => {:review_content, :review_rating},
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


    # if link not in database, persist the link in the database
    if !@link = Link.find_or_create_by(url: link_url_from_params)
      render json: {status: "failure", action: "construct_user_share", details: "link did not validate", errors: @review.errors.full_messages, token: token_from_params}, status: 200
      return
    end

    # persist link-tag-joins in the database
      # should be an array of tags
    tags_from_params.each do |tag|
      @tag = Tag.find_by(title: tag)

      # only if link_tag_join doesn't already exists
      if !LinkTagJoin.find_by(link_id: @link.id, tag_id: @tag.id)
        LinkTagJoin.create(tag_id: @tag.id, link_id: @link.id)
      end
    end

    # persist the review in the database
    @review = Review.new(reviewer_id: user_id, link_id: @link.id, content: review_content_from_params, rating: review_rating_from_params)

    if !@review.save
        render json: {status: "failure", action: "construct_user_share", details: "review did not validate", errors: @review.errors.full_messages, token: token_from_params}, status: 200
      return
    end

    # persist the use-share in the database
    @user_share = UserShare.new(user_id: user_id, link_id: @link.id, review_id: @review.id)

    if !@user_share.save
        render json: {status: "failure", action: "construct_user_share", details: "user_share did not validate", errors: @user_share.errors.full_messages, token: token_from_params}, status: 200
      return
    end
    # update review and any others with user-share
    @review.user_share_id = @user_share.id
    @review.save



    render json: {status: "success", action: "construct_user_share", user_share: @user_share, review: @review, link: @link, token: token_from_params}, status: 200
  end

  def update_user_share
    ## expected params ##
    # user_share: {
        # :id,
        # :token,
        # :review_information => {:review_content, :review_rating},
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

    @user_share = UserShare.find(user_share_id_from_params)

    @review = @user_share.review

    # update the review
    if !@review.update(content: review_content_from_params, rating: review_rating_from_params)
      render json: {status: "failure", action: "update_user_share", errors: @review.errors.full_messages, details: "review update did not validate"}, status: 200
      return
    end

    # update link (and link_tag_joins)
    @link = @user_share.link
    if @link.user_shares.length == 1
      # only user_share associated with this link
      # update link itself
      # update link-tag-joins
      if !@link.update(url: link_url_from_params)
        render json: {status: "failure", action: "update_user_share", errors: @link.errors.full_messages, details: "link update did not validate"}, status: 200
        return
      end

      @link_tag_joins = @link.link_tag_joins
      @link_tag_joins.each do |ltj|
        ltj.destroy
      end

      tags_from_params.each do |tag_title|
        # find the tag to use its id
        # construct ltj
        @tag = Tag.find_by(title: tag_title)
        LinkTagJoin.create(link_id: @link.id, tag_id: @tag.id)
      end

      render json: {status: "success", action: "update_user_share", link: @link}, status: 200
    else
      # not only user_share associated with this link
      # go through all user_shares associated with this link EXCEPT THIS USER_SHARE
        # gather all tag IDs
        # make these tag IDs be only tag IDs connected to the original link
      # construct new link
        # with all link_tag_joins given tag ids in params
      # need to update review's link_id to @new_link.id
      # need to update user_share's link_id to @new_link.id

      @new_link = Link.new(url: link_url_from_params)

      if !@new_link.save
        render json: {status: "failure", action: "update_user_share", errors: @new_link.errors.full_messages, details: "link update did not validate"}, status: 200
        return
      end


      # lessgoooo
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
