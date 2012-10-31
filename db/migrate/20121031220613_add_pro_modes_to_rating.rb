class AddProModesToRating < ActiveRecord::Migration
  def change
    add_column :ratings, :pro_guitar, :integer
    add_column :ratings, :pro_keyboard, :integer
    add_column :ratings, :pro_drums, :integer
    add_column :ratings, :pro_bass, :integer
    add_column :ratings, :pro_vocals, :integer
    rename_column :ratings, :vocal, :vocals
  end
end
