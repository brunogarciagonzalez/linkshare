class UserSharesController < ApplicationController
  # user_id: nil, review_id: nil, link_id: nil, active: true
  def construct_user_share
    link_id_from_params = strong_construct_user_share_params[:link_id]
    review_id_from_params = strong_construct_user_share_params[:review_id]
    token_from_params = strong_construct_user_share_params[:token]

    user_id = get_user_id_from_token(token_from_params)

    @user_share = UserShare.new(user_id: user_id, link_id: link_id_from_params, review_id: review_id_from_params)

    if @user_share.save
      render json: {status: "success", action: "construct_user_share", user_share: @user_share, token: token_from_params}, status: 200
    else
      render json: {status: "failure", action: "construct_user_share", details: @user_share.errors.full_messages}, status: 200
    end
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
    params.require(:user_share).permit(:link_id, :review_id, :token)
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
