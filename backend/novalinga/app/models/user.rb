class User < ApplicationRecord
    validates :email, presence: true
    validates :image, presence: true
    validates :uid, presence: true
    validates :token, presence: true, allow_blank: true
    validates :refresh_token, presence: true, allow_blank: true
    validates :expires_at, presence: true
    has_many :userscourses
    has_many :courses, through: :userscourses

    def expired?
        self.expires_at < Time.now
    end

    def to_params
        {'refresh_token' => refresh_token,
        'client_id' => ENV['GOOGLE_CLIENT_ID'],
        'client_secret' => ENV['GOOGLE_CLIENT_SECRET'],
        'grant_type' => 'refresh_token'}
    end

    def request_token_from_google
        url = URI("https://accounts.google.com/o/oauth2/token")
        Net::HTTP.post_form(url, self.to_params)
    end

    def refresh
        response = request_token_from_google
        data = JSON.parse(response.body)
        update_attributes(
        token: data['access_token'],
        expires_at: Time.now + (data['expires_in'].to_i).seconds)
    end

    def fresh_token
        refresh if expired?
        token 
    end

    

    

    
end
