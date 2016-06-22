require 'rspotify/oauth'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :spotify, Rails.application.secrets.spotify_client_id, Rails.application.secrets.spotify_client_secret, scope: 'playlist-read-private user-read-private user-read-email user-top-read user-library-read playlist-modify-public'
end
