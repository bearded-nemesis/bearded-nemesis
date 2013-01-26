require "spec_helper"

describe PlaylistSong do
  before(:each) do
    #FactoryGirl.reload
  end

  describe "players" do
    it "should return player's instrument" do
      user = User.new
      song = PlaylistSong.new bass_rocker: user
      song.instrument_for(user).should eq(:bass)
    end

    it "should return nil if they're not playing" do
      user = User.new
      song = PlaylistSong.new
      song.instrument_for(user).should eq(nil)
    end

    it "should return nil if the player is nil" do
      PlaylistSong.new.instrument_for(nil).should eq(nil)
    end
  end
end