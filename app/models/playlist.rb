class Playlist < ActiveRecord::Base
  attr_accessible :amountOfSongs, :includeUnratedSongs, :name, :unratedSongsRating

  belongs_to :user
end
