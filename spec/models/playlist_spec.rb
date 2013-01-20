require "spec_helper"

describe Playlist do
  describe "players" do
    it "should return all users" do
      first_user = FactoryGirl.create :user
      second_user = FactoryGirl.create :user

      playlist = Playlist.new name: "Foo", user: first_user
      playlist.users << second_user

      playlist.players.should include(first_user)
      playlist.players.should include(second_user)
    end
  end

  describe "adding auto-generated songs" do
    before(:each) do
      @user = FactoryGirl.create :user
      @songs = FactoryGirl.create_list :song, 15
      @user.songs << @songs.take(10)
      @playlist = FactoryGirl.create :playlist, user: @user
      @generator = double("generator")
    end

    it "should only include the owner's songs" do
      @generator.should_receive :generate do |arg|
        arg.keys.length.should eq(10)
        arg.keys.should include(@songs[0].id)
        arg.keys.should_not include(@songs[10].id)
      end.and_return([1])

      @playlist.add_generated_songs @generator, {@user.id => :bass}, false, 3
    end

    it "should not include existing songs" do
      @generator.should_receive :generate do |arg|
        arg.keys.should_not include(@songs[2].id)
      end.and_return([1])

      @playlist.songs.create song: @songs[2]
      @playlist.add_generated_songs @generator, {@user.id => :bass}, false, 3
    end

    it "should include user's ratings for songs" do
      @generator.should_receive :generate do |arg|
        arg[@user.id][@songs[2].id].should eq(4)
        arg[@user.id][@songs[1].id].should eq(3)
      end.and_return([1])

      @songs[2].ratings.create user: @user, bass: 4, drums: 5
      @playlist.add_generated_songs @generator, {@user.id => :bass}, false, 3
    end

    it "should remove unrated songs" do
      @generator.should_receive :generate do |arg|
        arg.keys.should include(@songs[1].id)
        arg.keys.length.should eq(1)
      end.and_return([1])

      @songs[2].ratings.create user: @user, bass: 4, drums: 5
      @playlist.add_generated_songs @generator, {@user.id => :bass}, true, 3
    end

    it "should add generated songs" do
      @generator.should_receive(:generate).and_return([@songs[4].id, @songs[7].id])
      @playlist.add_generated_songs @generator, {@user.id => :bass}, false, 3
      @playlist.songs.length.should eq(2)
      @playlist.songs.any? {|item| item.song == @songs[4]}.should eq(true)
      @playlist.songs.any? {|item| item.song == @songs[7]}.should eq(true)
    end

    it "should set the players instruments in each song" do
      @generator.should_receive(:generate).and_return([@songs[4].id, @songs[7].id])
      @playlist.add_generated_songs @generator, {@user.id => :bass}, false, 3
      @playlist.songs.length.should eq(2)
      @playlist.songs.each do |song|
        song.bass_rocker.should eq(@user)
      end
    end

    it "should ignore 'pro' for instrument selection" do
      @generator.should_receive(:generate).and_return([@songs[4].id, @songs[7].id])
      @playlist.add_generated_songs @generator, {@user.id => :pro_bass}, false, 3
      @playlist.songs.length.should eq(2)
      @playlist.songs.each do |song|
        song.bass_rocker.should eq(@user)
      end
    end
  end

  it "should not allow players to be added twice" do
    a_user = FactoryGirl.create :user

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
    me_user = FactoryGirl.create :user

    playlist = Playlist.new name: "Foo", user: me_user

    playlist.users << me_user
    playlist.save!
    playlist.reload

    playlist.players.count.should eq(1)
  end
end