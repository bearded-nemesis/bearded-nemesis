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

  def instrument_for(user)
    return nil if user.nil?

    ApplicationController::INSTRUMENTS.each do |instrument|
      return instrument if send(instrument.to_s + "_rocker") == user
    end

    nil

    #methods.each do |method|
    #  return method.to_s.gsub(/_rocker/, "").to_sym if method =~ /_rocker/ and send(method) == user
    #end
  end
end
