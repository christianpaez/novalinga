require 'rails_helper'
require 'byebug'
RSpec.describe "UsersCourses endpoint", type: :request do
    # describe "GET /userscourses" do
    #     before { get '/userscourses' }
    #         it "Should return 200 Status code" do
    #           payload = JSON.parse(response.body)
    #           expect(payload).to be_empty
    #           expect(response).to have_http_status(200)
    #         end
    # end
    # describe "with data in the database" do
    #     let!(:userscourses) { create_list(:userscourse, 10)}
    #     it " should return all the users courses" do
    #         get '/userscourses'
    #         payload = JSON.parse(response.body)
    #         expect(payload.size).to eq(userscourses.size)
    #         expect(response).to have_http_status(200)
    #     end
    # end
    # describe "GET /userscourses/:id" do
    #     let!(:userscourse) { create(:userscourse)}
    #     before { get "/userscourses/#{userscourse.id}" }
    #     it "Should return a single user course" do
    #         payload = JSON.parse(response.body)
    #         expect(payload).not_to be_empty
    #         expect(payload['id']).to eq(userscourse.id)
    #         expect(payload['user_id']).to eq(userscourse.user_id)
    #         expect(payload['course_id']).to eq(userscourse.course_id)
    #         expect(response).to have_http_status(200)
    #     end
    # end
    # describe "POST /userscourses" do
    #     let!(:userscourse) { create(:userscourse)}
    #     it "Should create a user course" do
    #         data = {
    #                 userscourse: {
    #                 user_id: userscourse.user_id,
    #                 course_id: userscourse.course_id
    #                 }
    #             }
    #         post '/userscourses', params: data
    #         response_body = JSON.parse(response.body)
    #         expect(response_body).not_to be_empty
    #         expect(response_body['user_id']).to eq(data[:userscourse][:user_id])
    #         expect(response_body['course_id']).to eq(data[:userscourse][:course_id])
    #         expect(response).to have_http_status(201)
    #     end
    # end

    # describe "PUT /userscourses/:id" do
    #     let!(:userscourse) { create(:userscourse)}
    #     it "Should update a user course" do
    #         data = {
    #             userscourse: {
    #                 user_id: userscourse.user_id,
    #                 course_id: userscourse.course_id
    #                 }
    #             }
    #         put "/userscourses/#{userscourse.id}", params: data
    #         response_body = JSON.parse(response.body)
    #         expect(response_body).not_to be_empty
    #         expect(response_body['id']).to eq(userscourse.id)
    #         expect(response_body['user_id']).to eq(data[:userscourse][:user_id])
    #         expect(response_body['course_id']).to eq(data[:userscourse][:course_id])
    #         expect(response).to have_http_status(200)
    #     end
    # end

    # describe "DELETE /userscourses/:id" do
    #     let!(:userscourse) { create(:userscourse)}
    #     it "Should delete a phrase" do
    #         delete "/userscourses/#{userscourse.id}"
    #         response_body = JSON.parse(response.body)
    #         expect(response_body).not_to be_empty
    #         expect(response_body['id']).to eq(userscourse.id)
    #          expect(response_body['user_id']).to eq(userscourse.user_id)
    #         expect(response_body['course_id']).to eq(userscourse.course_id)
    #         expect(response).to have_http_status(200)
    #     end
    # end
end