class UsersController < ApplicationController

  def login
    username_from_params = strong_login_params[:username]
    password_from_params = strong_login_params[:password]
    # need to turn password string into bcrypt hash
    # to compare /w user.password_digest
    @user = User.find_by(username: username_from_params)

    if @user && @user.authenticate(password_from_params)
      # send token

      token = generate_token(@user)

      render json: {status: "success", action: "login", user: @user, token: token}, status: 200
    else
      # send error
      render json: {status: "failure", action: "login", details: "incorrect username and/or password"}, status: 200
    end
  end

  def construct_account
    username_from_params = strong_construct_account_params[:username]
    password_from_params = strong_construct_account_params[:password]
    email_from_params = strong_construct_account_params[:email]

    @user = User.new(username: username_from_params, password: password_from_params, email: email_from_params)

    if @user.save
      token = generate_token(@user)
      render json: {status: "success", action: "construct_account", user: @user, token: token}, status: 200
    else
      render json: {status: "failure", action: "construct_account", errors: @user.errors.full_messages}, status: 200
    end
  end

  def get_account
    user_id_from_params = strong_get_account_params[:id]
    @user = User.find(user_id_from_params)

    if @user
      render json: {status: "success", action: "get_account", user: @user}, status: 200
    else
      render json: {status: "failure", action: "get_account", details: "user not found (by id)"}, status: 200
    end
  end

  def update_account
    # the user will need to be logged in, so a token will be needed
    token_from_params = strong_update_account_params[:token]
    new_username_from_params = strong_update_account_params[:username]
    new_password_from_params = strong_update_account_params[:password]
    new_email_from_params = strong_update_account_params[:email]

    @user = get_user_from_token(token_from_params)

    # update fields
    @user.username = new_username_from_params
    @user.password = new_password_from_params
    @user.email = new_email_from_params

    # if user.save
    if @user.save
      render json: {status: "success", action: "update_account", user: @user, token: token_from_params}, status: 200
    else
      render json: {status: "failure", action: "update_account", errors: @user.errors.full_messages}, status: 200
    end

  end

  def destroy_account
    # the user will need to be logged in, so a token will be needed
    # make them type in their credentials as confirmation [check against db]
    # destroy user-associated items (this isn't facebook!)
    token_from_params = strong_destroy_account_params[:token]

    @user = get_user_from_token(token_from_params)


    username_from_params = strong_update_account_params[:username]
    password_from_params = strong_update_account_params[:password]
    email_from_params = strong_update_account_params[:email]

    if (@user.username == username_from_params) && @user.authenticate(password_from_params) && (@user.email == email_from_params)
      # in front-end: window.localStorage.removeItem('token')

      # destroy user-associated:
      # reviews (& their corresponding review_comments based on review_id)
      @user.reviews.each do |review|
        review.review_comments.each do |review_comment|
          review_comment.destroy
        end
        review.destroy
      end

      # destroy user-associated:
      # review_comments (based on review_commenter_id)
      @user.review_comments.each do |review_comment|
        review_comment.destroy
      end

      # destroy user-associated:
      # tag_comments (based on tag_commenter_id)
      @user.tag_comments.each do |tag_comment|
        tag_comment.destroy
      end

      # destroy user-associated:
      # user_shares (based on user_id)
      @user.user_shares.each do |user_share|
        user_share.destroy
      end

      # destroy user
      @user.destroy

      render json: {status: "success", action: "destroy_account", user: @user}, status: 200
    else
      render json: {status: "failure", action: "destroy_account", user: @user, details: "username, password, and email must match database", token: token_from_params}, status: 200
    end

  end

  private
  #### params-related ####
  def strong_login_params
    params.require(:user).permit(:username, :password)
  end

  def strong_construct_account_params
    params.require(:user).permit(:username, :password, :email)
  end

  def strong_update_account_params
    params.require(:user).permit(:username, :password, :email, :token)
  end

  def strong_destroy_account_params
    params.require(:user).permit(:username, :password, :email, :token)
  end

  def strong_get_account_params
    params.require(:user).permit(:id)
  end

  #### helper functions ####
  def generate_token(user)
    alg = 'HS256'
    payload = {user_id: user.id}
    secret = "secret"

    token = JWT.encode(payload, secret, alg)
  end

  def get_user_from_token(token)
    secret = "secret"
    # decode payload: [{user_id: user.id}, {alg...}]
    payload = JWT.decode(token,secret, "HS256")
    byebug
    # find user
    User.find(payload[0]["user_id"])
  end
end
