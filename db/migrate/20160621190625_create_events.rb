class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.references :user
      t.string :playlist_id
      t.integer :settings_id

      t.timestamps null: false
    end
  end
end
