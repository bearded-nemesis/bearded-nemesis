class CreatePlaylists < ActiveRecord::Migration
  def change
    create_table :playlists do |t|
      t.string :name
      t.references :user
      t.integer :amount_of_songs
      t.boolean :include_unrated_songs
      t.integer :unrated_songs_rating

      t.timestamps
    end
    add_index :playlists, :user_id
  end
end
