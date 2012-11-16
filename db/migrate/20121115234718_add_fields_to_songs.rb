class AddFieldsToSongs < ActiveRecord::Migration
  def change
    add_column :songs, :year, :integer
    add_column :songs, :release_date, :date
    add_column :songs, :source, :string
  end
end
