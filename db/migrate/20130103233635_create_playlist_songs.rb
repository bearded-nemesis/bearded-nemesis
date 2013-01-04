class CreatePlaylistSongs < ActiveRecord::Migration
  def change
    create_table :playlist_songs do |t|
      t.references :playlist
      t.references :song
      t.integer :guitar_rocker_id
      t.integer :bass_rocker_id
      t.integer :drums_rocker_id
      t.integer :vocals_rocker_id
      t.integer :keyboard_rocker_id

      t.timestamps
    end
    add_index :playlist_songs, :song_id
    add_index :playlist_songs, :playlist_id
  end
end
