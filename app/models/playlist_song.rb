class PlaylistSong < ActiveRecord::Base
  belongs_to :playlist
  belongs_to :song
  attr_accessible :bass_rocker_id, :drums_rocker_id, :guitar_rocker_id, :keyboard_rocker_id, :vocals_rocker_id, :song, :playlist
end
