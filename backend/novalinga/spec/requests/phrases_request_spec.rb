require 'rails_helper'
require 'byebug'
RSpec.describe "Phrases endpoint", type: :request do
    describe "GET /phrases with no auth header" do
        before { get '/phrases' }
            it "Should return empty headers message" do
              response_body = JSON.parse(response.body)
              expect(response_body["message"]).to eq("Bad request")
              expect(response_body["error"]).to eq("Authorization header missing")
              expect(response).to have_http_status(400)
            end
    end

    describe "GET /phrases with invalid user uid" do
        before { get '/phrases', params:{}, headers: { 'Authorization' => 'xxxx' } }
            it "Should return user not found message" do
              response_body = JSON.parse(response.body)
              expect(response_body["message"]).to eq("Please login")
              expect(response_body["error"]).to eq("User not found")
              expect(response).to have_http_status(422)
            end
    end

    describe "GET /phrases with invalid expired token" do
        let!(:user) {create(:user)}
        before { get '/phrases', params:{}, headers: { 'Authorization' => user.uid } }
            it "Should return expired token message" do
              response_body = JSON.parse(response.body)
              expect(response_body["message"]).to eq("Please login")
              expect(response_body["error"]).to eq("User token expired")
              expect(response).to have_http_status(422)
            end
    end
    describe "GET /phrases" do
        let!(:user) {create(:user)}
        it "Should return 200 Status code" do
            expires_at = (Time.now + 300)
            user.expires_at = expires_at
            user.save
            get '/phrases', params:{}, headers: { 'Authorization' => user.uid }
            response_body = JSON.parse(response.body)
            expect(response_body["data"].size).to eq(0)
            expect(response_body["message"]).to eq("Phrases retrieved")
            expect(response).to have_http_status(200)
        end
    end
    describe "with data in the database" do
        let!(:phrases) { create_list(:phrase, 10)}
        let!(:user) {create(:user)}
        it " should return all the phrases" do
            expires_at = (Time.now + 300)
            user.expires_at = expires_at
            user.save
            get '/phrases', params:{}, headers: { 'Authorization' => user.uid }
            response_body = JSON.parse(response.body)
            expect(response_body["data"].size).to eq(phrases.size)
            expect(response_body["message"]).to eq("Phrases retrieved")
            expect(response).to have_http_status(200)
        end
    end

    describe "GET /phrases?lesson_id=" do
        let!(:user) {create(:user)}
        it "Should return 200 Status code" do
            expires_at = (Time.now + 300)
            user.expires_at = expires_at
            user.save
            get '/phrases?course_id=', params:{}, headers: { 'Authorization' => user.uid }
            response_body = JSON.parse(response.body)
            expect(response_body["data"].size).to eq(0)
            expect(response_body["message"]).to eq("Phrases retrieved")
            expect(response).to have_http_status(200)
        end
    end
    describe "query params lesson_id with data in the database" do
        let!(:lesson) {create(:lesson)}
        let!(:phrases) { create_list(:phrase, 10, lesson_id: lesson.id)}
        let!(:user) {create(:user)}
        it "should return all the phrases with given lesson id" do
            expires_at = (Time.now + 300)
            user.expires_at = expires_at
            user.save
            get "/phrases?lesson_id=#{lesson.id}", params:{}, headers: { 'Authorization' => user.uid }
            response_body = JSON.parse(response.body)
            expect(response_body["data"].size).to eq(phrases.size)
            expect(response_body["message"]).to eq("Phrases retrieved")
            expect(response).to have_http_status(200)
        end
    end

    describe "GET /phrases/:id with no auth header" do
        let!(:phrase) {create(:phrase)}
        before { get "/phrases/#{phrase.id}" }
            it "Should return empty headers message" do
              response_body = JSON.parse(response.body)
              expect(response_body["message"]).to eq("Bad request")
              expect(response_body["error"]).to eq("Authorization header missing")
              expect(response).to have_http_status(400)
            end
    end

    describe "GET /phrases/:id with invalid user uid" do
        let!(:phrase) {create(:phrase)}
        before { get "/phrases/#{phrase.id}", params:{}, headers: { 'Authorization' => 'xxxx' } }
            it "Should return user not found message" do
              response_body = JSON.parse(response.body)
              expect(response_body["message"]).to eq("Please login")
              expect(response_body["error"]).to eq("User not found")
              expect(response).to have_http_status(422)
            end
    end

    describe "GET /phrases/:id with invalid expired token" do
        let!(:user) {create(:user)}
        let!(:phrase) {create(:phrase)}
        before { get "/phrases/#{phrase.id}", params:{}, headers: { 'Authorization' => user.uid } }
            it "Should return expired token message" do
              response_body = JSON.parse(response.body)
              expect(response_body["message"]).to eq("Please login")
              expect(response_body["error"]).to eq("User token expired")
              expect(response).to have_http_status(422)
            end
    end
    describe "GET /phrases/:id" do
        let!(:phrase) { create(:phrase)}
        let!(:user) { create(:user)}
        it "Should return a single phrase" do
            expires_at = (Time.now + 300)
            user.expires_at = expires_at
            user.save
            get "/phrases/#{phrase.id}", params:{}, headers: { 'Authorization' => user.uid }
            response_body = JSON.parse(response.body)
            expect(response_body["data"]).not_to be_empty
            expect(response_body["data"]["id"]).to eq(phrase.id)
            expect(response_body["data"]['phonetic']).to eq(phrase.phonetic)
            expect(response_body["data"]['audio_url']).to eq(phrase.audio_url)
            expect(response_body["data"]['input_language']).to eq(phrase.input_language)
            expect(response_body["data"]['output_language']).to eq(phrase.output_language)
            expect(response_body["data"]['lesson_id']).to eq(phrase.lesson_id)
            expect(response_body["message"]).to eq("Phrase retrieved with id: #{phrase.id}")
            expect(response).to have_http_status(200)
        end
    end

    # describe "POST /phrases" do
    #     let!(:lesson) { create(:lesson)}
    #     it "Should create a phrase" do
    #         data = {
    #                 phrase: {
    #                 input_language: "hola", 
    #                 output_language: "hello",
    #                 phonetic: "jelou",
    #                 audio_url: "domain.com/file.mp3",
    #                 lesson_id: lesson.id
    #                 }
    #             }
    #         post '/phrases', params: data
    #         response_body = JSON.parse(response.body)
    #         expect(response_body).not_to be_empty
    #         expect(response_body['input_language']).to eq(data[:phrase][:input_language])
    #         expect(response_body['output_language']).to eq(data[:phrase][:output_language])
    #         expect(response_body['phonetic']).to eq(data[:phrase][:phonetic])
    #         expect(response_body['audio_url']).to eq(data[:phrase][:audio_url])
    #         expect(response_body['lesson_id']).to eq(data[:phrase][:lesson_id])
    #         expect(response).to have_http_status(201)
    #     end
    # end

    # describe "PUT /phrases/:id" do
    #     let!(:phrase) { create(:phrase)}
    #     it "Should update a phrase" do
    #         data = {
    #                 phrase: {
    #                 input_language: "hola", 
    #                 output_language: "hello",
    #                 phonetic: "jelou",
    #                 audio_url: "domain.com/file.mp3"
    #                 }
    #             }
    #         put "/phrases/#{phrase.id}", params: data
    #         response_body = JSON.parse(response.body)
    #         expect(response_body).not_to be_empty
    #         expect(response_body['id']).to eq(phrase.id)
    #         expect(response_body['input_language']).to eq(data[:phrase][:input_language])
    #         expect(response_body['output_language']).to eq(data[:phrase][:output_language])
    #         expect(response_body['phonetic']).to eq(data[:phrase][:phonetic])
    #         expect(response_body['audio_url']).to eq(data[:phrase][:audio_url])
    #         expect(response).to have_http_status(200)
    #     end
    # end

    # describe "DELETE /phrases/:id" do
    #     let!(:phrase) { create(:phrase)}
    #     it "Should delete a phrase" do
    #         delete "/phrases/#{phrase.id}"
    #         response_body = JSON.parse(response.body)
    #         expect(response_body).not_to be_empty
    #         expect(response_body['id']).to eq(phrase.id)
    #         expect(response_body['input_language']).to eq(phrase.input_language)
    #         expect(response_body['output_language']).to eq(phrase.output_language)
    #         expect(response_body['phonetic']).to eq(phrase.phonetic)
    #         expect(response_body['audio_url']).to eq(phrase.audio_url)
    #         expect(response_body['lesson_id']).to eq(phrase.lesson_id)
    #         expect(response).to have_http_status(200)
    #     end
    # end
end