module AuthHelper
    def decode(auth_header)
        begin 
            decoded_token = JWT.decode auth_header, ENV["JWT_SECRET"], true, { algorithm: 'HS256' }  
            decoded_token[0]["uid"]
        rescue 
            "Error verifying token"
        end

    end

    def encode(user)
        JWT.encode user, ENV["JWT_SECRET"], 'HS256'
    end
end