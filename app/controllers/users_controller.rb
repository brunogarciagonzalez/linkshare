class UsersController < ApplicationController

  def login
    username = params[:username]
    password = params[:password]
    # need to turn password string into bcrypt hash
    # to compare /w user.password_digest

    user = User.find_by(username: username)

    if user && user.authenticate(password)
      # send token

      generate_token(user)
      render json: {status: "success", token: token}
    else
      # send error
      render json: {status: "failure"}
    end
  end

  def construct_account # need to add route
    # take in params
    # create user with params
    # check errors
    # if user.errors.any?
      # return errors in json
    # else
      # the user was created so generate a token with user
      # and return token
  end

  private
  def generate_token(user)
    alg = 'HS256'
    payload = {user_id: user.id, username: user.username}
    secret = "secret"

    token = JWT.encode(payload, secret, alg)
  end

  def strong_login_params
    params.require(:login).permit(:username, :password)
  end
end
