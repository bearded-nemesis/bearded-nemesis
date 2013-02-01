class PlaylistSong < ActiveRecord::Base
  belongs_to :playlist
  belongs_to :song

  belongs_to :bass_rocker, :class_name => "User"
  belongs_to :drums_rocker, :class_name => "User"
  belongs_to :guitar_rocker, :class_name => "User"
  belongs_to :keyboard_rocker, :class_name => "User"
  belongs_to :vocals_rocker, :class_name => "User"

  belongs_to :pro_bass_rocker, :class_name => "User"
  belongs_to :pro_drums_rocker, :class_name => "User"
  belongs_to :pro_guitar_rocker, :class_name => "User"
  belongs_to :pro_keyboard_rocker, :class_name => "User"
  belongs_to :pro_vocals_rocker, :class_name => "User"

  attr_accessible :bass_rocker, :drums_rocker, :guitar_rocker,
                  :keyboard_rocker, :vocals_rocker,
                  :pro_bass_rocker, :pro_drums_rocker, :pro_guitar_rocker,
                  :pro_keyboard_rocker, :pro_vocals_rocker,
                  :song, :playlist

  def instrument_for(user)
    return nil if user.nil?

    ApplicationController::INSTRUMENTS_WITH_PRO.each do |instrument|
      return instrument if send(instrument.to_s + "_rocker") == user
    end

    nil
  end
end
