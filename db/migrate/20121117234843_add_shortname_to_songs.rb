class AddShortnameToSongs < ActiveRecord::Migration
  def change
    add_column :songs, :shortname, :string
  end
end
