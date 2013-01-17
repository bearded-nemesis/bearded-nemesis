class CreatePlaylistsUsers < ActiveRecord::Migration
  def change
    create_table :playlists_users, :id => false do |t|
      t.references :playlist
      t.references :user
    end
    add_index :playlists_users, [:playlist_id, :user_id]
  end
end
