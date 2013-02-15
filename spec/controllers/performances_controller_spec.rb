require "spec_helper"

describe PerformancesController do
  before(:each) do
    @user = FactoryGirl.create :user
    @songs = FactoryGirl.create_list :song, 3
    @playlist = FactoryGirl.create :playlist
    @playlist.players.create user: @user
    @songs.each do |song|
      @playlist.songs.create song: song, vocals_rocker: @user
    end
  end

  describe "rate" do
    it "should add a rating if one doesn't exist" do
      sign_in @user
      post :rate, id: @playlist.id, format: "json", song: @songs[1], rating: 4

      rating = @user.ratings.where(song_id: @songs[1]).first
      rating.vocals.should eq(4)
    end

    it "should update an existing rating" do
      Rating.create user: @user, song: @songs[1], vocals: 1

      sign_in @user
      post :rate, id: @playlist.id, format: "json", song: @songs[1], rating: 4

      rating = @user.ratings.where(song_id: @songs[1]).first
      rating.vocals.should eq(4)
    end
  end
end