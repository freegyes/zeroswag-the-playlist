class Mixtape < ActiveRecord::Base
  extend FriendlyId

  friendly_id :name

  has_many :contributions
  has_many :tracks, through: :contributions
  belongs_to :owner, class_name: 'User'

  before_save :parameterize_name
  after_create :create_playlist
  after_save :update_playlist

  validates :name, presence: true, uniqueness: true

  def parameterize_name
    self.name = name.parameterize
  end

  def create_playlist
    playlist = owner.spotify_user.create_playlist!(name)
    self.playlist_id = playlist.id
    contributions.create(user: owner)
    save
  end

  def update_playlist
    track_ids = []
    tracks.each do |track|
      track_ids << track.spotify_id
    end
    RSpotify::authenticate(Rails.application.secrets.spotify_client_id, Rails.application.secrets.spotify_client_secret)
    spotify_playlist.replace_tracks!(RSpotify::Track.find(track_ids.uniq.shuffle))
  end

  def spotify_playlist
    RSpotify::Playlist.find(owner.uid, playlist_id)
  end
end
