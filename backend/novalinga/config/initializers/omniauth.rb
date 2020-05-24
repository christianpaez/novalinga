Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV['GOOGLE_CLIENT_ID'], ENV['GOOGLE_CLIENT_SECRET'], 
  {
      scope: ['email',
      'https://www.googleapis.com/auth/gmail.modify'],
      skip_jwt: true,
      access_type: 'offline',
      image_size: 150,
    }
end