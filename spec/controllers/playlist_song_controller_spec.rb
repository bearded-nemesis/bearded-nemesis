require 'spec_helper'
require 'json'

describe PlaylistSongController do
  before :each do
    FactoryGirl.reload

    @playlist = FactoryGirl.create :playlist
    @user = FactoryGirl.create :user
    @song = FactoryGirl.create :song

    sign_in @user
  end

  describe "create" do
    before :each do
      post :create, playlist_id: @playlist.id, song_id: @song.id
      @association = PlaylistSong.where playlist_id: @playlist.id, song_id: @song.id
    end

    it "add specified song to playlist" do
      @association.should_not be_nil
    end

    it "should return a json representation of the association" do
      results = JSON.parse response.body
      results["playlist_id"].should eq(@playlist.id)
      results["song_id"].should eq(@song.id)
      results["id"].should eq(@association[0].id)
    end
  end
end