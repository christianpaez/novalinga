require 'rails_helper'
require 'byebug'
RSpec.describe "Lessons endpoint", type: :request do
    describe "GET /lessons" do
        before { get '/lessons' }
            it "Should return 200 Status code" do
              payload = JSON.parse(response.body)
              expect(payload).to be_empty
              expect(response).to have_http_status(200)
            end
    end
    describe "with data in the database" do
        let!(:lessons) { create_list(:lesson, 10)}
        it " should return all the lessons" do
            get '/lessons'
            payload = JSON.parse(response.body)
            expect(payload.size).to eq(lessons.size)
            expect(response).to have_http_status(200)
        end
    end
    describe "GET /lessons/:id" do
        let!(:lesson) { create(:lesson)}
        before { get "/lessons/#{lesson.id}" }
        it "Should return a single lesson" do
            payload = JSON.parse(response.body)
            expect(payload).not_to be_empty
            expect(payload['id']).to eq(lesson.id)
            expect(payload['title']).to eq(lesson.title)
            expect(payload['image_url']).to eq(lesson.image_url)
            expect(payload['course_id']).to eq(lesson.course_id)
            expect(response).to have_http_status(200)
        end
    end
    describe "POST /lessons" do
        let!(:course) { create(:course) }
        it "Should create a lesson" do
            data = {
                    lesson: {
                    title: "some title",
                    image_url: "domain.com/file.png",
                    course_id: course.id
                    }
                }
            post '/lessons', params: data
            response_body = JSON.parse(response.body)
            expect(response_body).not_to be_empty
            expect(response_body['title']).to eq(data[:lesson][:title])
            expect(response_body['image_url']).to eq(data[:lesson][:image_url])
            expect(response_body['course_id']).to eq(data[:lesson][:course_id])
            expect(response).to have_http_status(201)
        end
    end

    describe "PUT /lessons/:id" do
        let!(:lesson) { create(:lesson)}
        it "Should update a lesson" do
            data = {
                lesson: {
                    title: "some title",
                    image_url: "domain.com/file.png"
                    }
                }
            put "/lessons/#{lesson.id}", params: data
            response_body = JSON.parse(response.body)
            expect(response_body).not_to be_empty
            expect(response_body['id']).to eq(lesson.id)
            expect(response_body['title']).to eq(data[:lesson][:title])
            expect(response_body['image_url']).to eq(data[:lesson][:image_url])
            expect(response).to have_http_status(200)
        end
    end

    describe "DELETE /lessons/:id" do
        let!(:lesson) { create(:lesson)}
        it "Should delete a phrase" do
            delete "/lessons/#{lesson.id}"
            response_body = JSON.parse(response.body)
            expect(response_body).not_to be_empty
            expect(response_body['id']).to eq(lesson.id)
            expect(response_body['title']).to eq(lesson.title)
            expect(response_body['image_url']).to eq(lesson.image_url)
            expect(response).to have_http_status(200)
        end
    end
end