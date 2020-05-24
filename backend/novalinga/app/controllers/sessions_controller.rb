class SessionsController < ApplicationController
  layout false
  def index
  end
  def create
    user_info = request.env["omniauth.auth"]
    @auth = request.env['omniauth.auth']['credentials']
    @auth["email"] = user_info["info"]["email"]
    @auth["image"] = user_info["info"]["image"]
    @auth["uid"] = user_info["uid"]
    Token.create(
      access_token: @auth['token'],
      refresh_token: @auth['refresh_token'],
      expires_at: Time.at(@auth['expires_at']).to_datetime
      )
  end
  def new
  end

  def destroy
    Token.last.destroy  
    redirect_to root_path
  end
end
