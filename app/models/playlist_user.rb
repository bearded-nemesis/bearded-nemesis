class PlaylistUser < ActiveRecord::Base
  attr_accessible :playlist, :user, :default_instrument

  belongs_to :playlist
  belongs_to :user
end
