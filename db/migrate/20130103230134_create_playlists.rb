class CreatePlaylists < ActiveRecord::Migration
  def change
    create_table :playlists do |t|
      t.string :name
      t.references :user
      t.int :amountOfSongs
      t.bool :includeUnratedSongs
      t.int :unratedSongsRating

      t.timestamps
    end
  end
end
