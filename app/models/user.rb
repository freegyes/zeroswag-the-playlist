require 'rspotify'

class User < ActiveRecord::Base
  devise :database_authenticatable

  def spotify_user
    RSpotify::User.new(JSON.parse(spotify_hash))
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.display_name   # assuming the user model has a name
      user.image_url = auth.info.image # assuming the user model has an image
      user.spotify_hash = auth.to_json
    end
  end
end
