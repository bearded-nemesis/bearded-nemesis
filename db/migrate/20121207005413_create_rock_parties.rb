class CreateRockParties < ActiveRecord::Migration
  def change
    create_table :rock_parties do |t|
      t.string :name
      t.string :location
      t.datetime :eventDate
      t.references :user

      t.timestamps
    end
  end
end
