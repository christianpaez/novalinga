class User < ApplicationRecord
    validates :email, presence: true
    validates :image, presence: true
    validates :uid, presence: true
    validates :token, presence: true, allow_blank: true
    validates :refresh_token, presence: true, allow_blank: true
    validates :expires_at, presence: true
    def expired?
        self.expires_at < Time.now
    end
end
