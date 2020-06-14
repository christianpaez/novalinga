module SessionsHelper
    def create_params
        params.require(:user).permit(:email, :image, :uid, :token, :refresh_token, :expires_at)
    end
end
