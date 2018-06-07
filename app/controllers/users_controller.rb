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

      render json: {status: "success", action: "login", user: @user, token: token}
    else
      # send error
      render json: {status: "failure", action: "login", details: "incorrect username and/or password"}
    end
  end

  def construct_account
    username_from_params = strong_construct_account_params[:username]
    password_from_params = strong_construct_account_params[:password]
    email_from_params = strong_construct_account_params[:email]

    @user = User.new(username: username_from_params, password: password_from_params, email: email_from_params)

    if @user.save
      token = generate_token(@user)
      render json: {status: "success", action: "construct_account", user: @user, token: token}
    else
      render json: {status: "failure", action: "construct_account", errors: @user.errors.full_messages}
    end
  end

  def update_account
    secret = "secret"
    token_from_params = strong_update_account_params[:token]
    new_username_from_params = strong_update_account_params[:username]
    new_password_from_params = strong_update_account_params[:password]
    new_email_from_params = strong_update_account_params[:email]

    # decode payload: [{user_id: user.id}, {alg...}]
    payload = JWT.decode(token_from_params,secret, "HS256")

    # find user
    @user = User.find(payload[0]["user_id"])

    # update fields
    @user.username = new_username_from_params
    @user.password = new_password_from_params
    @user.email = new_email_from_params

    # if user.save
    if @user.save
      render json: {status: "success", action: "update_account", user: @user, token: token_from_params}
    else
      render json: {status: "failure", action: "update_account", errors: @user.errors.full_messages}
    end

  end

  private
  def generate_token(user)
    alg = 'HS256'
    payload = {user_id: user.id}
    secret = "secret"

    token = JWT.encode(payload, secret, alg)
  end

  def strong_login_params
    params.require(:user).permit(:username, :password)
  end

  def strong_construct_account_params
    params.require(:user).permit(:username, :password, :email)
  end

  def strong_update_account_params
    params.require(:user).permit(:username, :password, :email, :token)
  end
end
