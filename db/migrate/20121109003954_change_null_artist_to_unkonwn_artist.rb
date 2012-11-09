class ChangeNullArtistToUnkonwnArtist < ActiveRecord::Migration
  def up
    execute <<-SQL
      UPDATE songs
        SET artist = '[unkown artist]'
        WHERE artist IS NULL
    SQL
  end

  def down
    execute <<-SQL
      UPDATE songs
        SET artist = NULL
        WHERE artist = '[unkown artist]'
    SQL
  end
end
