class Playlist < ActiveRecord::Base
  belongs_to :user
  attr_accessible :amount_of_songs, :include_unrated_songs, :name, :unrated_songs_rating, :user

  has_many :users
  has_many :playlist_songs
end
