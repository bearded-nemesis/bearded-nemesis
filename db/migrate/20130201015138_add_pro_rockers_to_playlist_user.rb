class AddProRockersToPlaylistUser < ActiveRecord::Migration
  def change
    add_column :playlist_songs, :pro_guitar_rocker_id, :integer
    add_column :playlist_songs, :pro_bass_rocker_id, :integer
    add_column :playlist_songs, :pro_drums_rocker_id, :integer
    add_column :playlist_songs, :pro_vocals_rocker_id, :integer
    add_column :playlist_songs, :pro_keyboard_rocker_id, :integer
  end
end
