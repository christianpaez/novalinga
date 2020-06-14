FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    image { Faker::Internet.url }
    uid {Faker::Internet.uuid}
    token {Faker::Internet.uuid}
    refresh_token {Faker::Internet.uuid}
    expires_at {Time.now.to_datetime}
  end
end