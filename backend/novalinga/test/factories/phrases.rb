FactoryBot.define do
  factory :phrase do
    input_language { Faker::Lorem.sentence }
    output_language { Faker::Lorem.sentence }
    phonetic { Faker::Lorem.sentence }
    audio_url { Faker::Internet.url }
    lesson
  end
end