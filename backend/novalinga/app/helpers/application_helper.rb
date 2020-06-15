module ApplicationHelper
    def require_login
            auth_header = request.headers["Authorization"]
            if auth_header.nil?
                render json: {message: "Bad request", error: "Authorization header missing"}, status: 400
            else 
            @user = User.find_by uid: request.headers["Authorization"]
            if @user
                token_expired = @user.expired?
                if token_expired
                    render json: {message: "Please login", error: "User token expired"}, status: 422
                end
            else
                render json: {message: "Please login", error: "User not found"}, status: 422
            end
        end
    end
end
