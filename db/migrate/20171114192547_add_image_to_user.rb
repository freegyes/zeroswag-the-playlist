class AddImageToUser < ActiveRecord::Migration
  def change
    add_column :users, :image_uid,  :string
    add_column :users, :image_name, :string 
  end
end
