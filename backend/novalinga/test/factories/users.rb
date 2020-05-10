FactoryBot.define do
  factory :users do
    email { Faker::Lorem.email }
    username { Faker::Lorem.username }
    password { Faker::Lorem.password }
  end
end