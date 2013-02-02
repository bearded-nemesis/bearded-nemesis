require 'spec_helper'

describe PlaylistsController do
  describe "list" do
    #render_views

    before :each do
      @user = FactoryGirl.create :user
      @playlist_owned = FactoryGirl.create :playlist, user: @user, name: "I own it"
      @playlist_player = FactoryGirl.create :playlist, name: "I play in it"
      @playlist_player.users << @user
      @playlist_player.save
      @playlist_neither = FactoryGirl.create :playlist, name: "I should not see this"
    end

    it "should show playlists I own" do
      sign_in @user
      get :index

      assigns(:playlists).should include(@playlist_owned)
    end

    it "should show playlists for which I'm a player" do
      sign_in @user
      get :index

      assigns(:playlists).should include(@playlist_player)
    end

    it "should not show playlists I'm not associated with" do
      sign_in @user
      get :index

      assigns(:playlists).should_not include(@playlist_neither)
    end
  end
end
