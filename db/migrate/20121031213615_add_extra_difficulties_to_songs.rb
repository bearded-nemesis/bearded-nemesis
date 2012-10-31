class AddExtraDifficultiesToSongs < ActiveRecord::Migration
  def change
    add_column :songs, :pro_guitar_difficulty, :integer
    add_column :songs, :pro_keyboard_difficulty, :integer
    add_column :songs, :pro_drums_difficulty, :integer
    add_column :songs, :pro_bass_difficulty, :integer
    add_column :songs, :pro_vocals_difficulty, :integer
  end
end
