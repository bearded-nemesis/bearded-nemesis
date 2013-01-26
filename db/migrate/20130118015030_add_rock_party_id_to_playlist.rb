class AddRockPartyIdToPlaylist < ActiveRecord::Migration
  def change
    add_column :playlists, :rock_party_id, :integer
  end
end
