require 'rails_helper'
require 'byebug'
RSpec.describe "Lessons endpoint", type: :request do

    describe "GET /lessons with no auth header" do
        before { get '/lessons' }
            it "Should return empty headers message" do
              response_body = JSON.parse(response.body)
              expect(response_body["message"]).to eq("Bad request")
              expect(response_body["error"]).to eq("Authorization header missing")
              expect(response).to have_http_status(400)
            end
    end

    describe "GET /lessons with invalid user uid" do
        before { get '/lessons', params:{}, headers: { 'Authorization' => 'xxxx' } }
            it "Should return user not found message" do
              response_body = JSON.parse(response.body)
              expect(response_body["message"]).to eq("Please login")
              expect(response_body["error"]).to eq("User not found")
              expect(response).to have_http_status(422)
            end
    end

    describe "GET /lessons with invalid expired token" do
        let!(:user) {create(:user)}
        before { get '/lessons', params:{}, headers: { 'Authorization' => user.uid } }
            it "Should return expired token message" do
              response_body = JSON.parse(response.body)
              expect(response_body["message"]).to eq("Please login")
              expect(response_body["error"]).to eq("User token expired")
              expect(response).to have_http_status(422)
            end
    end
    describe "GET /lessons" do
        let!(:user) {create(:user)}
        it "Should return 200 Status code" do
            expires_at = (Time.now + 300)
            user.expires_at = expires_at
            user.save
            get '/lessons', params:{}, headers: { 'Authorization' => user.uid }
            response_body = JSON.parse(response.body)
            expect(response_body["data"].size).to eq(0)
            expect(response_body["message"]).to eq("Lessons retrieved")
            expect(response).to have_http_status(200)
        end
    end
    describe "with data in the database" do
        let!(:lessons) { create_list(:lesson, 10)}
        let!(:user) {create(:user)}
        it " should return all the lessons" do
            expires_at = (Time.now + 300)
            user.expires_at = expires_at
            user.save
            get '/lessons', params:{}, headers: { 'Authorization' => user.uid }
            response_body = JSON.parse(response.body)
            expect(response_body["data"].size).to eq(lessons.size)
            expect(response_body["message"]).to eq("Lessons retrieved")
            expect(response).to have_http_status(200)
        end
    end

    describe "GET /lessons/:id with no auth header" do
        let!(:lesson) {create(:lesson)}
        before { get "/lessons/#{lesson.id}" }
            it "Should return empty headers message" do
              response_body = JSON.parse(response.body)
              expect(response_body["message"]).to eq("Bad request")
              expect(response_body["error"]).to eq("Authorization header missing")
              expect(response).to have_http_status(400)
            end
    end

    describe "GET /lessons/:id with invalid user uid" do
        let!(:lesson) {create(:lesson)}
        before { get "/lessons/#{lesson.id}", params:{}, headers: { 'Authorization' => 'xxxx' } }
            it "Should return user not found message" do
              response_body = JSON.parse(response.body)
              expect(response_body["message"]).to eq("Please login")
              expect(response_body["error"]).to eq("User not found")
              expect(response).to have_http_status(422)
            end
    end

    describe "GET /lessons/:id with invalid expired token" do
        let!(:user) {create(:user)}
        let!(:lesson) {create(:lesson)}
        before { get "/lessons/#{lesson.id}", params:{}, headers: { 'Authorization' => user.uid } }
            it "Should return expired token message" do
              response_body = JSON.parse(response.body)
              expect(response_body["message"]).to eq("Please login")
              expect(response_body["error"]).to eq("User token expired")
              expect(response).to have_http_status(422)
            end
    end
    describe "GET /lessons/:id" do
        let!(:lesson) { create(:lesson)}
        let!(:user) { create(:user)}
        it "Should return a single lesson" do
            expires_at = (Time.now + 300)
            user.expires_at = expires_at
            user.save
            get "/lessons/#{lesson.id}", params:{}, headers: { 'Authorization' => user.uid }
            response_body = JSON.parse(response.body)
            expect(response_body["data"]).not_to be_empty
            expect(response_body["data"]["id"]).to eq(lesson.id)
            expect(response_body["data"]['title']).to eq(lesson.title)
            expect(response_body["data"]['image_url']).to eq(lesson.image_url)
            expect(response_body["data"]['course_id']).to eq(lesson.course_id)
            expect(response_body["message"]).to eq("Lesson retrieved with id: #{lesson.id}")
            expect(response).to have_http_status(200)
        end
    end
    # describe "POST /lessons" do
    #     let!(:course) { create(:course) }
    #     it "Should create a lesson" do
    #         data = {
    #                 lesson: {
    #                 title: "some title",
    #                 image_url: "domain.com/file.png",
    #                 course_id: course.id
    #                 }
    #             }
    #         post '/lessons', params: data
    #         response_body = JSON.parse(response.body)
    #         expect(response_body).not_to be_empty
    #         expect(response_body['title']).to eq(data[:lesson][:title])
    #         expect(response_body['image_url']).to eq(data[:lesson][:image_url])
    #         expect(response_body['course_id']).to eq(data[:lesson][:course_id])
    #         expect(response).to have_http_status(201)
    #     end
    # end

    # describe "PUT /lessons/:id" do
    #     let!(:lesson) { create(:lesson)}
    #     it "Should update a lesson" do
    #         data = {
    #             lesson: {
    #                 title: "some title",
    #                 image_url: "domain.com/file.png"
    #                 }
    #             }
    #         put "/lessons/#{lesson.id}", params: data
    #         response_body = JSON.parse(response.body)
    #         expect(response_body).not_to be_empty
    #         expect(response_body['id']).to eq(lesson.id)
    #         expect(response_body['title']).to eq(data[:lesson][:title])
    #         expect(response_body['image_url']).to eq(data[:lesson][:image_url])
    #         expect(response).to have_http_status(200)
    #     end
    # end

    # describe "DELETE /lessons/:id" do
    #     let!(:lesson) { create(:lesson)}
    #     it "Should delete a phrase" do
    #         delete "/lessons/#{lesson.id}"
    #         response_body = JSON.parse(response.body)
    #         expect(response_body).not_to be_empty
    #         expect(response_body['id']).to eq(lesson.id)
    #         expect(response_body['title']).to eq(lesson.title)
    #         expect(response_body['image_url']).to eq(lesson.image_url)
    #         expect(response).to have_http_status(200)
    #     end
    # end
end