require 'rails_helper'

RSpec.describe "Phonetics", type: :request do

  describe "GET /phonetics" do
    it "returns http success" do
      get "/phonetics"
      payload = JSON.parse(response.body)
      expect(payload).to be_empty
      expect(response).to have_http_status(200)
    end
  end

  describe "with data in the database" do
      let!(:phonetics) { create_list(:phonetic, 10) }
      it " should return all the phonetics" do
          get '/phonetics'
          payload = JSON.parse(response.body)
          expect(payload.size).to eq(phonetics.size)
          expect(response).to have_http_status(200)
      end
  end

  describe "GET /phonetics/:id" do
      let!(:phonetic) { create(:phonetic)}
      before { get "/phonetics/#{phonetic.id}" }
      it "Should return a single phonetic" do
          payload = JSON.parse(response.body)
          expect(payload).not_to be_empty
          expect(payload['id']).to eq(phonetic.id)
          expect(payload['input_language']).to eq(phonetic.input_language)
          expect(payload['output_language']).to eq(phonetic.output_language)
          expect(payload['phonetic']).to eq(phonetic.phonetic)
          expect(payload['audio_url']).to eq(phonetic.audio_url)
          expect(response).to have_http_status(200)
      end
  end

end
