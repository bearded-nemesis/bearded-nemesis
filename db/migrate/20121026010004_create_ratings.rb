class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.integer :user_id
      t.integer :song_id

      t.integer :guitar
      t.integer :bass
      t.integer :vocal
      t.integer :overall
      t.integer :drums
      t.integer :keyboard

      t.timestamps
    end
  end
end
