class AddExtraFieldsToPlaylistUsers < ActiveRecord::Migration
  def change
    add_column :playlists_users, :default_instrument, :string
  end
end
