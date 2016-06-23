require 'rspotify'

class User < ActiveRecord::Base
  devise :database_authenticatable

  has_many :contributions
  has_many :mixtapes, through: :contributions
  has_many :owned_mixtapes, class_name: 'Mixtape'

  def spotify_user
    RSpotify::User.new(JSON.parse(spotify_hash))
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.display_name
      user.image_url = auth.info.images.first.url
      user.spotify_hash = auth.to_json
    end
  end
end
