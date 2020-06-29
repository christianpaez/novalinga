require 'rails_helper'
require 'byebug'
RSpec.describe "UsersCourses endpoint", type: :request do
    describe "POST /userscourses with no auth header" do
        before { post '/userscourses' }
            it "Should return empty headers message" do
              response_body = JSON.parse(response.body)
              expect(response_body["message"]).to eq("Bad request")
              expect(response_body["error"]).to eq("Authorization header missing")
              expect(response).to have_http_status(400)
            end
    end

    describe "POST /userscourses with invalid user uid" do
        before { post '/userscourses', params:{}, headers: { 'Authorization' => 'xxxx' } }
            it "Should return user not found message" do
              response_body = JSON.parse(response.body)
              expect(response_body["message"]).to eq("Please login")
              expect(response_body["error"]).to eq("User not found")
              expect(response).to have_http_status(422)
            end
    end

    describe "POST /userscourses with invalid expired token" do
        let!(:user) {create(:user)}
        before { post '/userscourses', params:{}, headers: { 'Authorization' => user.uid } }
            it "Should return expired token message" do
              response_body = JSON.parse(response.body)
              expect(response_body["message"]).to eq("Please login")
              expect(response_body["error"]).to eq("User token expired")
              expect(response).to have_http_status(422)
            end
    end

    describe "POST /userscourses" do
      let!(:user) {create(:user)}
      let!(:course) {create(:course)}
            it "Should create entry on join table" do
                expires_at = (Time.now + 300)
                user.expires_at = expires_at
                user.save
                data = {
                            userscourse: {
                            user_id: user.id,
                            course_id: course.id
                            }
                        }
              post '/userscourses', params: data, headers: { 'Authorization' => user.uid } 
              response_body = JSON.parse(response.body)
              expect(response_body["message"]).to eq("Created Userscourse with id:#{Userscourse.first.id}")
              expect(response_body["data"]["user_id"]).to eq(user.id)
              expect(response_body["data"]["course_id"]).to eq(course.id)
              expect(response).to have_http_status(201)
            end
    end

    describe "DELETE /userscourses/:course_id with no auth header" do
      let!(:userscourse) { create(:userscourse)}
      before { delete "/userscourses/#{userscourse.course_id}" }
          it "Should return empty headers message" do
            response_body = JSON.parse(response.body)
            expect(response_body["message"]).to eq("Bad request")
            expect(response_body["error"]).to eq("Authorization header missing")
            expect(response).to have_http_status(400)
          end
  end

  describe "DELETE /userscourses with invalid user uid" do
    let!(:userscourse) { create(:userscourse)}
      before { delete "/userscourses/#{userscourse.course_id}", params:{}, headers: { 'Authorization' => 'xxxx' } }
          it "Should return user not found message" do
            response_body = JSON.parse(response.body)
            expect(response_body["message"]).to eq("Please login")
            expect(response_body["error"]).to eq("User not found")
            expect(response).to have_http_status(422)
          end
  end

  describe "DELETE /userscourses with invalid expired token" do
      let!(:user) {create(:user)}
      let!(:userscourse) { create(:userscourse)}

          it "Should return expired token message" do
            delete "/userscourses/#{userscourse.course_id}", params:{}, headers: { 'Authorization' => user.uid }
            response_body = JSON.parse(response.body)
            expect(response_body["message"]).to eq("Please login")
            expect(response_body["error"]).to eq("User token expired")
            expect(response).to have_http_status(422)
          end
  end

    describe "DELETE /userscourses/:course_id" do
        let!(:user) { create(:user)}
        let!(:userscourse) { create(:userscourse, user_id: user.id)}
        it "Should delete a join table entry" do
            expires_at = (Time.now + 300)
            user.expires_at = expires_at
            user.save
            delete "/userscourses/#{userscourse["course_id"]}", params:{}, headers: { 'Authorization' => user.uid }
            response_body = JSON.parse(response.body)
            expect(response_body).not_to be_empty
            expect(response_body['message']).to eq("Userscourse deleted with id:#{userscourse.id}")
            expect(response).to have_http_status(200)
        end
    end
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