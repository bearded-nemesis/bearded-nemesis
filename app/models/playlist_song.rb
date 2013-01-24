class PlaylistSong < ActiveRecord::Base
  belongs_to :playlist
  belongs_to :song

  belongs_to :bass_rocker, :class_name => "User"
  belongs_to :drums_rocker, :class_name => "User"
  belongs_to :guitar_rocker, :class_name => "User"
  belongs_to :keyboard_rocker, :class_name => "User"
  belongs_to :vocals_rocker, :class_name => "User"

  attr_accessible :bass_rocker, :drums_rocker, :guitar_rocker,
                  :keyboard_rocker, :vocals_rocker,
                  :song, :playlist
end
