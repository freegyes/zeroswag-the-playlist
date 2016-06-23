class Contribution < ActiveRecord::Base
  belongs_to :user
  belongs_to :mixtape
  has_many :tracks

  after_create :set_tracks

  def set_tracks
    user.spotify_user.top_tracks(time_range: 'short_term').each do |track|
      tracks.create(spotify_id: track.id)
    end
  end
end
