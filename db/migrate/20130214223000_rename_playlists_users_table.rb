class RenamePlaylistsUsersTable < ActiveRecord::Migration
  def change
    add_column :playlists_users, :id, :primary_key
    rename_table :playlists_users, :playlist_users
  end
end
