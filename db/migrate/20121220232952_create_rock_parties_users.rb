class CreateRockPartiesUsers < ActiveRecord::Migration
  def up
    create_table :rock_parties_users, :id => false do |t|
      t.references :user
      t.references :rock_party
    end
    add_index :rock_parties_users, [:rock_party_id, :user_id]
    add_index :rock_parties_users, [:user_id, :rock_party_id]
  end

  def down
    drop_table :rock_parties_users
  end
end
