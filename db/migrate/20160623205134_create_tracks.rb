class CreateTracks < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
      t.integer :contribution_id
      t.string :spotify_id

      t.timestamps null: false
    end
  end
end
