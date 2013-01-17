class Playlist < ActiveRecord::Base
  belongs_to :user
  attr_accessible :amount_of_songs, :include_unrated_songs, :name, :unrated_songs_rating, :user

  has_and_belongs_to_many :users, :uniq => true
  has_many :playlist_songs

  def players
    users + [user]
  end
end
