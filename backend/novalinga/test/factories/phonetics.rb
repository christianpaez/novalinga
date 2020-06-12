FactoryBot.define do
  factory :phonetic do
    input_language { Faker::Lorem.sentence }
    output_language { Faker::Lorem.sentence }
    phonetic { Faker::Lorem.sentence }
    audio_url { Faker::Internet.url }
  end
end