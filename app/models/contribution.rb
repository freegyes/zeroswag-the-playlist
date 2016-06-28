class Contribution < ActiveRecord::Base
  belongs_to :user
  belongs_to :mixtape
  has_many :tracks

  after_create :set_tracks
  after_create :follow_playlist

  def set_tracks
    RSpotify::authenticate(Rails.application.secrets.spotify_client_id, Rails.application.secrets.spotify_client_secret)
    top_tracks = user.spotify_user.top_tracks(time_range: 'medium_term')
    top_tracks = user.spotify_user.top_tracks(time_range: 'short_term') if top_tracks.empty?
    top_tracks = user.spotify_user.top_tracks(time_range: 'long_term') if top_tracks.empty?
    top_tracks.each do |track|
      tracks.create(spotify_id: track.id)
    end
  end

  def follow_playlist
    RSpotify::authenticate(Rails.application.secrets.spotify_client_id, Rails.application.secrets.spotify_client_secret)
    user.spotify_user.follow(mixtape.spotify_playlist)
  end
end
