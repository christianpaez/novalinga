require 'rails_helper'
require 'byebug'
RSpec.describe "Courses endpoint", type: :request do

    describe "GET /courses with no auth header" do
        before { get '/courses' }
            it "Should return empty headers message" do
              response_body = JSON.parse(response.body)
              expect(response_body["message"]).to eq("Bad request")
              expect(response_body["error"]).to eq("Authorization header missing")
              expect(response).to have_http_status(400)
            end
    end

    describe "GET /courses with invalid user uid" do
        before { get '/courses', params:{}, headers: { 'Authorization' => 'xxxx' } }
            it "Should return user not found message" do
              response_body = JSON.parse(response.body)
              expect(response_body["message"]).to eq("Please login")
              expect(response_body["error"]).to eq("User not found")
              expect(response).to have_http_status(422)
            end
    end

    describe "GET /courses with invalid expired token" do
        let!(:user) {create(:user)}
        before { get '/courses', params:{}, headers: { 'Authorization' => user.uid } }
            it "Should return expired token message" do
              response_body = JSON.parse(response.body)
              expect(response_body["message"]).to eq("Please login")
              expect(response_body["error"]).to eq("User token expired")
              expect(response).to have_http_status(422)
            end
    end

    describe "GET /courses" do
        let!(:user) {create(:user)}
            it "Should return 200 Status code" do
                expires_at = (Time.now + 300)
                user.expires_at = expires_at
                user.save
                get '/courses', params:{}, headers: { 'Authorization' => user.uid }
                response_body = JSON.parse(response.body)
                expect(response_body["data"].size).to eq(0)
                expect(response_body["message"]).to eq("Courses retrieved")
                expect(response).to have_http_status(200)
            end
    end
    describe "with data in the database" do
        let!(:courses) { create_list(:course, 10) }
        let!(:user) {create(:user)}
        it " should return all the courses" do
            expires_at = (Time.now + 300)
            user.expires_at = expires_at
            user.save
            get '/courses', params:{}, headers: { 'Authorization' => user.uid } 
            response_body = JSON.parse(response.body)
            expect(response_body["message"]).to eq("Courses retrieved")
            expect(response_body["data"].size).to eq(courses.size)
            expect(response).to have_http_status(200)
        end
    end

    describe "GET /courses/:id with no auth header" do
        let!(:course) {create(:course)}
        before { get "/courses/#{course.id}" }
            it "Should return empty headers message" do
              response_body = JSON.parse(response.body)
              expect(response_body["message"]).to eq("Bad request")
              expect(response_body["error"]).to eq("Authorization header missing")
              expect(response).to have_http_status(400)
            end
    end

    describe "GET /courses/:id with invalid user uid" do
        let!(:course) {create(:course)}
        before { get "/courses/#{course.id}", params:{}, headers: { 'Authorization' => 'xxxx' } }
            it "Should return user not found message" do
              response_body = JSON.parse(response.body)
              expect(response_body["message"]).to eq("Please login")
              expect(response_body["error"]).to eq("User not found")
              expect(response).to have_http_status(422)
            end
    end

    describe "GET /courses/:id with invalid expired token" do
        let!(:user) {create(:user)}
        let!(:course) {create(:course)}
        before { get "/courses/#{course.id}", params:{}, headers: { 'Authorization' => user.uid } }
            it "Should return expired token message" do
              response_body = JSON.parse(response.body)
              expect(response_body["message"]).to eq("Please login")
              expect(response_body["error"]).to eq("User token expired")
              expect(response).to have_http_status(422)
            end
    end

    describe "GET /courses/:id" do
        let!(:course) { create(:course)}
        let!(:user) { create(:user)}
        it "Should return a single course" do
            expires_at = (Time.now + 300)
            user.expires_at = expires_at
            user.save
            get "/courses/#{course.id}", params:{}, headers: { 'Authorization' => user.uid }
            response_body = JSON.parse(response.body)
            expect(response_body).not_to be_empty
            expect(response_body["data"]['id']).to eq(course.id)
            expect(response_body["data"]['input_language']).to eq(course.input_language)
            expect(response_body["data"]['output_language']).to eq(course.output_language)
            expect(response_body["data"]['title']).to eq(course.title)
            expect(response_body["data"]['image_url']).to eq(course.image_url)
            expect(response_body["message"]).to eq("Course retrieved with id: #{course.id}")
            expect(response).to have_http_status(200)
        end
    end
    # describe "POST /courses" do
    #     let!(:course) { create(:course)}
    #     it "Should create a course" do
    #         data = {
    #                 course: {
    #                 input_language: "hola", 
    #                 output_language: "hello",
    #                 title: "jelou",
    #                 image_url: "domain.com/file.png"
    #                 }
    #             }
    #         post '/courses', params: data
    #         response_body = JSON.parse(response.body)
    #         expect(response_body).not_to be_empty
    #         expect(response_body['input_language']).to eq(data[:course][:input_language])
    #         expect(response_body['output_language']).to eq(data[:course][:output_language])
    #         expect(response_body['title']).to eq(data[:course][:title])
    #         expect(response_body['image_url']).to eq(data[:course][:image_url])
    #         expect(response).to have_http_status(201)
    #     end
    # end

    # describe "PUT /courses/:id" do
    #     let!(:course) { create(:course)}
    #     it "Should update a course" do
    #         data = {
    #                 course: {
    #                     input_language: "hola", 
    #                     output_language: "hello",
    #                     title: "jelou",
    #                     image_url: "domain.com/file.png"
    #                 }
    #             }
    #         put "/courses/#{course.id}", params: data
    #         response_body = JSON.parse(response.body)
    #         expect(response_body).not_to be_empty
    #         expect(response_body['id']).to eq(course.id)
    #         expect(response_body['input_language']).to eq(data[:course][:input_language])
    #         expect(response_body['output_language']).to eq(data[:course][:output_language])
    #         expect(response_body['title']).to eq(data[:course][:title])
    #         expect(response_body['image_url']).to eq(data[:course][:image_url])
    #         expect(response).to have_http_status(200)
    #     end
    # end

    # describe "DELETE /courses/:id" do
    #     let!(:course) { create(:course)}
    #     it "Should delete a course" do
    #         delete "/courses/#{course.id}"
    #         response_body = JSON.parse(response.body)
    #         expect(response_body).not_to be_empty
    #         expect(response_body['id']).to eq(course.id)
    #         expect(response_body['input_language']).to eq(course.input_language)
    #         expect(response_body['output_language']).to eq(course.output_language)
    #         expect(response_body['title']).to eq(course.title)
    #         expect(response_body['image_url']).to eq(course.image_url)
    #         expect(response).to have_http_status(200)
    #     end
    # end
end