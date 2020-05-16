require 'rails_helper'
require 'byebug'
RSpec.describe "Courses endpoint", type: :request do
    describe "GET /courses" do
        before { get '/courses' }
            it "Should return 200 Status code" do
              payload = JSON.parse(response.body)
              expect(payload).to be_empty
              expect(response).to have_http_status(200)
            end
    end
    describe "with data in the database" do
        let!(:courses) { create_list(:course, 10) }
        it " should return all the courses" do
            get '/courses'
            payload = JSON.parse(response.body)
            expect(payload.size).to eq(courses.size)
            expect(response).to have_http_status(200)
        end
    end
    describe "GET /courses/:id" do
        let!(:course) { create(:course)}
        before { get "/courses/#{course.id}" }
        it "Should return a single phrase" do
            payload = JSON.parse(response.body)
            expect(payload).not_to be_empty
            expect(payload['id']).to eq(course.id)
            expect(payload['input_language']).to eq(course.input_language)
            expect(payload['output_language']).to eq(course.output_language)
            expect(payload['title']).to eq(course.title)
            expect(payload['image_url']).to eq(course.image_url)
            expect(response).to have_http_status(200)
        end
    end
    describe "POST /courses" do
        let!(:course) { create(:course)}
        it "Should create a course" do
            data = {
                    course: {
                    input_language: "hola", 
                    output_language: "hello",
                    title: "jelou",
                    image_url: "domain.com/file.png"
                    }
                }
            post '/courses', params: data
            response_body = JSON.parse(response.body)
            expect(response_body).not_to be_empty
            expect(response_body['input_language']).to eq(data[:course][:input_language])
            expect(response_body['output_language']).to eq(data[:course][:output_language])
            expect(response_body['title']).to eq(data[:course][:title])
            expect(response_body['image_url']).to eq(data[:course][:image_url])
            expect(response).to have_http_status(201)
        end
    end

    describe "PUT /courses/:id" do
        let!(:course) { create(:course)}
        it "Should update a course" do
            data = {
                    course: {
                        input_language: "hola", 
                        output_language: "hello",
                        title: "jelou",
                        image_url: "domain.com/file.png"
                    }
                }
            put "/courses/#{course.id}", params: data
            response_body = JSON.parse(response.body)
            expect(response_body).not_to be_empty
            expect(response_body['id']).to eq(course.id)
            expect(response_body['input_language']).to eq(data[:course][:input_language])
            expect(response_body['output_language']).to eq(data[:course][:output_language])
            expect(response_body['title']).to eq(data[:course][:title])
            expect(response_body['image_url']).to eq(data[:course][:image_url])
            expect(response).to have_http_status(200)
        end
    end

    describe "DELETE /courses/:id" do
        let!(:course) { create(:course)}
        it "Should delete a course" do
            delete "/courses/#{course.id}"
            response_body = JSON.parse(response.body)
            expect(response_body).not_to be_empty
            expect(response_body['id']).to eq(course.id)
            expect(response_body['input_language']).to eq(course.input_language)
            expect(response_body['output_language']).to eq(course.output_language)
            expect(response_body['title']).to eq(course.title)
            expect(response_body['image_url']).to eq(course.image_url)
            expect(response).to have_http_status(200)
        end
    end
end