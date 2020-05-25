class User < ApplicationRecord
    validates :email, presence: true
    validates :image, presence: true
    validates :uid, presence: true
    validates :token, presence: true
    validates :refresh_token, presence: true
    validates :expires_at, presence: true
end
