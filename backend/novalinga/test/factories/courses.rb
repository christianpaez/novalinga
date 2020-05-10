FactoryBot.define do
  factory :course do
    input_language { Faker::Lorem.sentence }
    output_language { Faker::Lorem.sentence }
    title { Faker::Lorem.word }
    image_url { Faker::Internet.url }
  end
end