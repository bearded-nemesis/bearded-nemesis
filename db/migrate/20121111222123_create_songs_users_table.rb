class CreateSongsUsersTable < ActiveRecord::Migration
  def up
    create_table :songs_users, :id => false do |t|
      t.references :song
      t.references :user
    end
    add_index :songs_users, [:song_id, :user_id]
    add_index :songs_users, [:user_id, :song_id]
  end

  def down
    drop_table :songs_users
  end
end
