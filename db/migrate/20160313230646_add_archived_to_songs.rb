class AddArchivedToSongs < ActiveRecord::Migration
  def change
    add_column :songs, :archived, :boolean, default: false
  end
end
