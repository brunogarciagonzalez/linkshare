class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods
  before_action :authorized

  def user
   @user = @user || authenticate_or_request_with_http_token do |jwt_token, options|
     begin
       decoded_token = JWT.decode(jwt_token, "secret")

     rescue JWT::DecodeError
       return nil
     end

     if decoded_token[0]["user_id"]
       @user ||= User.find(decoded_token[0]["user_id"])
     else
     end
   end
  end

  def logged_in?
   !!@user
  end

  def authorized
   render json: {message: "Unauthorized" }, status: 401 unless logged_in?
  end
end
