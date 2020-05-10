FactoryBot.define do
  factory :lesson do
    title { Faker::Lorem.word }
    image_url { Faker::Internet.url }
    course
  end
end