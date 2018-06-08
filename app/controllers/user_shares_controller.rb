class UserSharesController < ApplicationController
  # user_id: nil, review_id: nil, link_id: nil, active: true
  def construct_user_share
    ## expected params ####
    # user_share: {
        # :token,
        # :review_information => {:review_content, :review_rating},
        # :link_information => {:url},
        # :tags => [...tags]
    # }

    ## link-related ##
    link_url_from_params = strong_construct_user_share_params[:link_information]["url"]

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
      LinkTagJoin.create(tag_id: @tag.id, link_id: @link.id)
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

  def destroy_user_share
    user_share_id_from_params = strong_destroy_user_share_params[:id]

    @user_share = UserShare.find(user_share_id_from_params)

    if @user_share
      # destroy/deactivate user_share-associated items
        # link if this only user_share with link
        byebug
          if @user_share.link.user_shares.length == 1
            @user_share.link.destroy
          end

      # review and review-comments (see users_controller#destroy)
        @user_share.review.review_comments.each do |review_comment|
          review_comment.destroy
        end

        @user_share.review.destroy

      # destroy user_share
      @user_share.destroy

      render json: {status: "success", action: "destroy_user_share", user_share: @user_share}, status: 200
    else
      render json: {status: "failure", action: "destroy_user_share", user_share: @user_share, details: "user_share not found (by id)"}, status: 200
    end
  end

  private
  #### params-related ####
  def strong_construct_user_share_params
    params.require(:user_share).permit(:token, :review_information => [:content, :rating], :link_information => [:url], tags: [])
  end

  def strong_destroy_user_share_params
    params.require(:user_share).permit(:id)
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
