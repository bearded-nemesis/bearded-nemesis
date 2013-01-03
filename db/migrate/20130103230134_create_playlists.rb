class CreatePlaylists < ActiveRecord::Migration
  def change
    create_table :playlists do |t|
      t.string :name
      t.references :user
      t.integer :amountOfSongs
      t.boolean :includeUnratedSongs
      t.integer :unratedSongsRating

      t.timestamps
    end
  end
end
