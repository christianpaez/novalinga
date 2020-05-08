require 'rails_helper'
require 'byebug'
RSpec.describe "Phrases endpoint", type: :request do
    describe "GET /phrases" do
        before { get '/phrases' }
            it "Should return 200 Status code" do
                payload = JSON.parse(response.body)
                expect(payload).to be_empty
                expect(response).to have_http_status(200)
            end
    end
    describe "with data in the database" do
        let!(:phrases) { create_list(:phrases, 10)}
        it " should return all the phrases" do
            get '/phrases'
            payload = JSON.parse(response.body)
            expect(payload.size).to eq(posts.size)
            expect(response).to have_http_status(200)
        end
    end
    describe "GET /phrases/:id" do
        let!(:phrase) { create(:phrase)}
        before { get "/phrases/#{phrase.id}" }
        it "Should return a single phrase" do
            payload = JSON.parse(response.body)
            expect(payload).not_to be_empty
            expect(payload['id']).to eq(phrase.id)
            expect(payload['input_language']).to eq(phrase.input_language)
            expect(payload['output_language']).to eq(phrase.output_language)
            expect(payload['phonetic']).to eq(phrase.phonetic)
            expect(payload['audio_url']).to eq(phrase.audio_url)
            expect(payload['lesson_id']).to eq(phrase.lesson_id)
            expect(response).to have_http_status(200)
        end
    end
end