class Playlist < ActiveRecord::Base
  attr_accessible :amountOfSongs, :includeUnratedSongs, :name, :unratedSongsRating, :user
end
