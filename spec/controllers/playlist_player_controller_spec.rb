require "spec_helper"

describe PlaylistPlayerController do
  before(:each) do
    @users = FactoryGirl.create_list :user, 2
    @playlist = FactoryGirl.create :playlist

    @playlist.players.create user: @users[0], default_instrument: :pro_drums
    @playlist.players.create user: @users[1], default_instrument: :vocals
    @playlist.user = @users[1]
  end

  describe "index" do
    it "should return json details about all the players in a playlist" do
      sign_in @users[1]
      get :index, playlist_id: @playlist.id, format: "json"
puts response.body
      results = JSON.parse response.body

      results.each_with_index do |item, index|
        item["id"] = @users[index].id
        item["name"] = @users[index].name
        item["email"] = @users[index].email
      end

      results["players"][0]["default_instrument"] = "pro_drums"
      results["players"][1]["default_instrument"] = "vocals"
    end
  end
end