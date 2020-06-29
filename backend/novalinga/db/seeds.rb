require 'faker' 

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Destroy All models

Phonetic.destroy_all
Lesson.destroy_all
Course.destroy_all
Phrase.destroy_all
User.destroy_all

user = User.new({
    email: Faker::Internet.email ,
    image: Faker::Internet.url ,
    uid:Faker::Internet.uuid,
    token:Faker::Internet.uuid,
    refresh_token:Faker::Internet.uuid,
    expires_at:Time.now.to_datetime
})
user.save
course = Course.new({
    input_language: Faker::Lorem.sentence,
    output_language: Faker::Lorem.sentence,
    title: Faker::Lorem.word,
    image_url: Faker::Internet.url
})
course.save

Userscourse.create course: course, user: user
10.times do
    phonetic = Phonetic.new({
        input_language:  Faker::Lorem.sentence ,
        output_language:  Faker::Lorem.sentence ,
        phonetic:  Faker::Lorem.sentence ,
        audio_url:  Faker::Internet.url 
    })
    phonetic.save
end

5.times do
    lesson = Lesson.new({
        title: Faker::Lorem.word,
        image_url: Faker::Internet.url,
        course_id: course[:id]
    })
    lesson.save
    10.times do
        phrase = Phrase.new({
            input_language: Faker::Lorem.sentence,
            output_language: Faker::Lorem.sentence,
            phonetic: Faker::Lorem.sentence,
            audio_url: Faker::Internet.url,
            lesson_id: lesson.id
        })
        phrase.save
    end
end
