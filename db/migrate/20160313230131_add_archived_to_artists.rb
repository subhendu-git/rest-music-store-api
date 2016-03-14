class AddArchivedToArtists < ActiveRecord::Migration
  def change
    add_column :artists, :archived, :boolean, default: false
  end
end
