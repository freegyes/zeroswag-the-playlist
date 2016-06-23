class RenameUserIdToOwnerIdInMixtapes < ActiveRecord::Migration
  def change
    rename_column :mixtapes, :user_id, :owner_id
  end
end
