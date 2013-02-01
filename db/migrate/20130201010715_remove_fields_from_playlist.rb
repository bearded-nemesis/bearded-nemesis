class RemoveFieldsFromPlaylist < ActiveRecord::Migration
  def change
    remove_column :playlists, :amount_of_songs
    remove_column :playlists, :include_unrated_songs
    remove_column :playlists, :unrated_songs_rating
  end
end
