require "spec_helper"

describe Playlist do
  describe "players" do
    it "should return all users" do
      first_user = User.new email: "me@example.com",
                            password: "password"
      second_user = User.new email: "you@example.com",
                             password: "password"

      playlist = Playlist.new name: "Foo", user: first_user
      playlist.users << second_user

      playlist.players.should include(first_user)
      playlist.players.should include(second_user)
    end
  end
end