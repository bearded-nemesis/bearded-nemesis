class CreateAdminWhitelists < ActiveRecord::Migration
  def change
    create_table :admin_whitelists do |t|
      t.string :email

      t.timestamps
    end
  end
end
