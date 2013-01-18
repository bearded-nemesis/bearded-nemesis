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

  it "should not allow players to be added twice" do
    Admin::Whitelist.create! email: "me@example.com"

    a_user = User.create! email: "me@example.com",
                          password: "password"

    playlist = Playlist.new name: "Foo"

    playlist.users << a_user
    playlist.save!
    playlist.reload

    playlist.users << a_user
    playlist.save!
    playlist.reload

    playlist.users.count.should eq(1)
  end

  it "should not allow the owner to be added as a user" do
    Admin::Whitelist.create! email: "me@example.com"

    me_user = User.create! email: "me@example.com",
                           password: "password"

    playlist = Playlist.new name: "Foo", user: me_user

    playlist.users << me_user
    playlist.save!
    playlist.reload

    playlist.players.count.should eq(1)
  end
end