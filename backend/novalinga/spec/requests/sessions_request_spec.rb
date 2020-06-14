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

  # describe "GET /index" do
  #   it "returns http success" do
  #     get "/sessions/index"
  #     expect(response).to have_http_status(:success)
  #   end
  # end

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
    it "Update User User after google login" do
        let!(:user) { create(:user)}
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
        expect(created_user.expires_at).to eq(Time.at(stub_omniauth.current_time))
    end
  end

  describe "TODO" do
    it "LOGOUT OPERATIONS" do
        let!(:user) { create(:user)}
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
        expect(created_user.expires_at).to eq(Time.at(stub_omniauth.current_time))
    end
  end

  describe "TODO" do
    it "FRESH TOKEN" do
        let!(:user) { create(:user)}
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
        expect(created_user.expires_at).to eq(Time.at(stub_omniauth.current_time))
    end
  end

  describe "TODO" do
    it "EXPIRED TOKEN?" do
        let!(:user) { create(:user)}
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
        expect(created_user.expires_at).to eq(Time.at(stub_omniauth.current_time))
    end
  end

  # describe "GET /new" do
  #   it "returns http success" do
  #     get "/sessions/new"
  #     expect(response).to have_http_status(:success)
  #   end
  # end

end
