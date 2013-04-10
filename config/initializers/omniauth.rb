OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  # provider :facebook, ENV['FACEBOOK_APP_ID'], ENV['FACEBOOK_SECRET']
  provider :facebook, '321222854671109', 'fb5ec97502c8687518871fe85a92dfb3', :scope => 'video_upload'
end

