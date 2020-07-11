module ApplicationHelper
    def require_login
            auth_header = request.headers["Authorization"]
            if auth_header.nil?
                render json: {message: "Bad request", error: "Authorization header missing"}, status: 400
            else 
                hmac_secret = 'my$ecretK3y'
                decoded_token = JWT.decode auth_header, hmac_secret, true, { algorithm: 'HS256' }

                # Array
                # [
                #   {"data"=>"test"}, # payload
                #   {"alg"=>"HS256"} # header
                # ]
                puts "decoded_token #{decoded_token.class}"
                puts "decoded_token #{decoded_token}"
                puts "decoded_token #{decoded_token[0]["uid"]}"
                user_uid = decoded_token[0]["uid"]
            @user = User.find_by uid: user_uid
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
