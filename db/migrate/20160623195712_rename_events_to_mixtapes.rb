class RenameEventsToMixtapes < ActiveRecord::Migration
  def change
    rename_table :events, :mixtapes
  end
end
