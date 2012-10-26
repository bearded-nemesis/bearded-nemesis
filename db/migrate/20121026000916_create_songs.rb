class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.string :name
      t.string :genre
      t.integer :guitar_difficulty
      t.integer :bass_difficulty
      t.integer :song_difficulty
      t.integer :drums_difficulty
      t.integer :vocals_difficulty
      t.integer :keyboard_difficulty

      t.timestamps
    end
  end
end
