class SessionsController < ApplicationController
  include SessionsHelper
  layout false
  skip_before_action :verify_authenticity_token, :except => [:logout]

  def create
    user_info = request.env["omniauth.auth"]
    @user = User.find_by uid:user_info[:uid] 
    if @user 
      #user already exists
      user_params = {
        email: user_info["info"]["email"],
        image: user_info["info"]["image"],
        uid: user_info["uid"].to_s,
        token: user_info["credentials"]["token"],
        refresh_token: user_info["credentials"]["refresh_token"],
        expires_at: Time.at(user_info["credentials"]["expires_at"]).to_datetime
      }
      if @user.update(user_params)
          @user = user_params
          hmac_secret = 'my$ecretK3y'

          token = JWT.encode @user, hmac_secret, 'HS256'

          redirect_to "#{Rails.application.config.frontend_url}/#{token}"
      else
        render json: "Error Updating User", status: 422
      end
    else
      # new user creation
      @user = {
      email: user_info["info"]["email"],
      image: user_info["info"]["image"],
      uid: user_info["uid"].to_s,
      token: user_info["credentials"]["token"],
      refresh_token: user_info["credentials"]["refresh_token"],
      expires_at: Time.at(user_info["credentials"]["expires_at"]).to_datetime
      }
      User.create(@user)
      hmac_secret = 'my$ecretK3y'

      token = JWT.encode @user, hmac_secret, 'HS256'}
      
      redirect_to "#{Rails.application.config.frontend_url}/#{token}"
    end
    
    # Token.create(
    #   access_token: @auth['token'],
    #   refresh_token: @auth['refresh_token'],
    #   expires_at: Time.at(@auth['expires_at']).to_datetime
    #   )
  end
  def new
  end

  def logout
    @user = User.find_by uid: params[:uid] 
    if @user
      # destroy user token
      if @user.update_attributes({
        token: "",
        refresh_token: "",
        expires_at: Time.now
      })
      render json: {message: "Logout Successful", data: @user}, status: :ok
      else
        render json: {message: "Logout Failed", error: @user.errors}, status: :unprocessable_entity
      end
    else
      render json: "User not found", status: :unprocessable_entity
    end
  end

  def expired
    @user = User.find_by uid: params[:uid]
    if @user
      user_expired = @user.expired?
      render json: {
        message: "Expiration verified",
        data: user_expired
      },
      status: :ok
    else
      render json: {
        message: "User Not Found",
        error: @user.errors
      },
      status: :unprocessable_entity
    end
  end

  def fresh_token
    @user = User.find_by uid: params[:uid]
    @user.fresh_token
      render json: {
        message: "Token retrieved/refreshed",
        data: @user
      },
      status: :ok
  end


  private
  def create_params
    params.require(:user).permit(:email, :image, :uid, :token, :refresh_token, :expires_at)
  end
end
