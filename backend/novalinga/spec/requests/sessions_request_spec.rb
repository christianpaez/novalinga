require 'rails_helper'

RSpec.describe "Sessions", type: :request do

  def stub_omniauth
      # first, set OmniAuth to run in test mode
      OmniAuth.config.test_mode = true
      # then, provide a set of fake oauth data that
      # omniauth will use when a user tries to authenticate:
      OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
          provider: "google_oauth2",
          uid: "123456789",
          info:{
              email: "mail@domail.com",
              unverified_email: "mail@domail.com",
              verified_email: true,
              image: "https://domain.com/image.jpg"
          },
          credentials: {
              token: "xxxxxx",
              refresh_token: "xxxxxxx.1234",
              expires_at: 1592105974,
              expires: true
          },
          extra: {
              id_token: "xxxxxx",
              raw_info: {
                  sub: "123456789",
                  picture: "https://domain.com/image.jpg",
                  email: "mail@domail.com",
                  email_verified: true
              }
          }

      })
  end

  describe "GET /create" do
    it "Create new User after google login" do
        stub_omniauth
        visit root_path
        expect(page).to have_link("Authenticate with Google!")
        click_link "Authenticate with Google!"
        created_user = User.first
        expect(created_user.email).to eq(stub_omniauth.info.email)
        expect(created_user.image).to eq(stub_omniauth.info.image)
        expect(created_user.uid).to eq(stub_omniauth.uid)
        expect(created_user.token).to eq(stub_omniauth.credentials.token)
        expect(created_user.refresh_token).to eq(stub_omniauth.credentials.refresh_token)
        expect(created_user.expires_at).to eq(Time.at(stub_omniauth.credentials.expires_at).to_datetime)
    end
  end

  describe "GET /create" do
    let!(:user) { create(:user)}

    it "Update User User after google login" do
        user.uid = "123456789"
        user.save
        stub_omniauth
        visit root_path
        expect(page).to have_link("Authenticate with Google!")
        click_link "Authenticate with Google!"
        created_user = User.find(user.id)
        expect(created_user.email).to eq(stub_omniauth.info.email)
        expect(created_user.image).to eq(stub_omniauth.info.image)
        expect(created_user.uid).to eq(stub_omniauth.uid)
        expect(created_user.token).to eq(stub_omniauth.credentials.token)
        expect(created_user.refresh_token).to eq(stub_omniauth.credentials.refresh_token)
        expect(created_user.expires_at).to eq(Time.at(stub_omniauth.credentials.expires_at))
    end
  end

  describe "DELETE /logout/:uid" do
    let!(:user) { create(:user)}
    
    it "Logout existing user" do
      delete "/logout/#{user.uid}"
      response_body = JSON.parse(response.body)
      expect(response_body["message"]).to eq("Logout Successful")
      expect(response_body["data"]["email"]).to eq(user.email)
      expect(response_body["data"]["image"]).to eq(user.image)
      expect(response_body["data"]["uid"]).to eq(user.uid)
      expect(response_body["data"]["token"]).to eq("")
      expect(response_body["data"]["refresh_token"]).to eq("")
      expect(response_body["data"]["expires_at"] < Time.now).to eq(true)
      expect(response).to have_http_status(200)
    end
  end

  describe "Get expired token expiration" do
    let!(:user) { create(:user)}
    it "Should get user expired? as boolean true" do
      user.expires_at = Time.now.to_datetime
      user.save
      get "/expired/#{user.uid}"  
      response_body = JSON.parse(response.body)
      expect(response_body["message"]).to eq("Expiration verified")
      expect(response_body["data"]).to eq(true)
      expect(response).to have_http_status(200)
      end
  end

  describe "Get valid token expiration" do
    let!(:user) { create(:user)}
    it "Should get user expired? as boolean true" do
      user.expires_at = (Time.now + 300).to_datetime
      user.save
      get "/expired/#{user.uid}" 
      response_body = JSON.parse(response.body)
      expect(response_body["message"]).to eq("Expiration verified")
      expect(response_body["data"]).to eq(false)
      expect(response).to have_http_status(200)
      end
  end
  
  # Note: this test makes use of the oauth google API, 
  # since user data comes from Faker the model Http request to
  # the oauth's api fails, therefore, expires_at will not be compared with Time.now
  describe "Refresh Expired token" do
    let!(:user) { create(:user)}
    it "Should get token expired message" do
      expires_at = (Time.now - 300).to_datetime
      user.expires_at = expires_at
      user.save
      get "/fresh-token/#{user.uid}" 
      response_body = JSON.parse(response.body)
      expect(response_body["message"]).to eq("Token retrieved/refreshed")
      expect(response_body["data"]["email"]).to eq(user.email)
      expect(response_body["data"]["image"]).to eq(user.image)
      expect(response_body["data"]["uid"]).to eq(user.uid)
      expect(response_body["data"]["token"]).not_to eq(user.token)
      expect(response_body["data"]["refresh_token"]).to eq(user.refresh_token)
      expect(response_body["data"]["expires_at"] > expires_at).to eq(true)
      expect(response).to have_http_status(200)
      end
  end
  describe "Get valid token" do
    let!(:user) { create(:user)}
    it "Should get user valid token" do
      expires_at = (Time.now + 300).to_datetime
      user.expires_at = expires_at
      user.save
      get "/fresh-token/#{user.uid}" 
      response_body = JSON.parse(response.body)

      byebug
      expect(response_body["message"]).to eq("Token retrieved/refreshed")
      expect(response_body["data"]["email"]).to eq(user.email)
      expect(response_body["data"]["image"]).to eq(user.image)
      expect(response_body["data"]["uid"]).to eq(user.uid)
      expect(response_body["data"]["token"]).to eq(user.token)
      expect(response_body["data"]["refresh_token"]).to eq(user.refresh_token)
      expect(response_body["data"]["expires_at"]).to eq(expires_at)
      expect(response).to have_http_status(200)
      end
  end
end
