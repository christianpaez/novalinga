class SessionsController < ApplicationController
  layout false
  def index
  end
  def create
    user_info = request.env["omniauth.auth"]
    @user = User.find_by uid:user_info[:uid] 
    if @user 
      puts "user already exists"
    else
      puts "new user"
      @user = {
      email: user_info["info"]["email"],
      image: user_info["info"]["image"],
      uid: user_info["uid"].to_s,
      token: user_info["credentials"]["token"],
      refresh_token: user_info["credentials"]["refresh_token"],
      expires_at: Time.at(user_info["credentials"]["expires_at"]).to_datetime
      }
      User.create(@user)
    end
    
    # Token.create(
    #   access_token: @auth['token'],
    #   refresh_token: @auth['refresh_token'],
    #   expires_at: Time.at(@auth['expires_at']).to_datetime
    #   )
  end
  def new
  end

  def destroy
    redirect_to root_path
  end

  private
  def create_params
    params.require(:user).permit(:email, :image, :uid, :token, :refresh_token, :expires_at)
  end
end
