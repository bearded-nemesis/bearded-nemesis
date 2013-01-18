class Playlist < ActiveRecord::Base
  belongs_to :user
  attr_accessible :amount_of_songs, :include_unrated_songs, :name, :unrated_songs_rating, :user, :rock_party

  has_and_belongs_to_many :users, :uniq => true do
    def <<(new_item)
      super new_item unless new_item == proxy_association.owner.user
    end
  end
  has_many :playlist_songs
  belongs_to :rock_party

  def players
    users + [user]
  end
end
