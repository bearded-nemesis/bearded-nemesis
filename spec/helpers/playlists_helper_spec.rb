require "spec_helper"

describe PlaylistsHelper do
  describe "#instrument_select_list" do
    it "should return a valid select list" do
      player = FactoryGirl.create :user
      song = FactoryGirl.create :song
      playlist_song = PlaylistSong.create :bass_rocker => player, song: song

      select = helper.instrument_select_list playlist_song, player

      select.should have_selector("option[value=bass][selected=selected]")
    end
  end
end