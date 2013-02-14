require 'spec_helper'
require 'json'

describe SongsController do
  before :each do
    FactoryGirl.reload
    @user = FactoryGirl.create :user
    @songs = FactoryGirl.create_list :song, 110
    @songs.each_with_index do |song, i|
      @user.songs << song unless i % 2 == 1
    end
    @user.save

    sign_in @user
  end

  describe "list" do
    it "should show the first 100 songs" do
      get :index
      assigns(:songs).length.should eq(100)
    end
  end

  describe "search" do
    it "should show songs that match" do
      get :search, term: "58"
      assigns(:songs).length.should eq(1)
    end

    it "should show songs I own that match" do
      get :search, term: "10", mine: true
      assigns(:songs).length.should eq(5)
    end

    it "should show 10 songs that match when using json" do
      get :search, term: "1", mine: true, format: :json
      results = JSON.parse response.body
      results.length.should eq(10)
    end
  end
end