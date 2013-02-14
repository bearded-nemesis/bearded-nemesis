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
    it "add specified song to playlist" do
      #post :create
      #assigns(:songs).length.should eq(100)
    end
  end
end