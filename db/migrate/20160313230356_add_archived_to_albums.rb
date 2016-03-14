class AddArchivedToAlbums < ActiveRecord::Migration
  def change
    add_column :albums, :archived, :boolean, default: false
  end
end
