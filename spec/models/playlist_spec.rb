require "spec_helper"

describe Playlist do
  before(:each) do
    #FactoryGirl.reload
  end

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
      end

      @playlist.add_generated_songs @generator, {@user.id => :bass}
    end

    it "should not include existing songs" do
      @generator.should_receive :generate do |arg|
        arg.keys.should_not include(@songs[2].id)
      end

      @playlist.songs.create song: @songs[2]
      @playlist.add_generated_songs @generator, {@user.id => :bass}
    end

    it "should include user's ratings for songs" do
      @generator.should_receive :generate do |arg|
        arg[@songs[2].id][@user.id].should eq(4)
        arg[@songs[1].id][@user.id].should eq(3)
      end

      @songs[2].ratings.create user: @user, bass: 4, drums: 5
      @playlist.add_generated_songs @generator, {@user.id => :bass}
    end

    it "should remove unrated songs" do
      @generator.should_receive :generate do |arg|
        arg.keys.should include(@songs[2].id)
        arg.keys.length.should eq(1)
      end

      @songs[2].ratings.create user: @user, bass: 4, drums: 5
      @playlist.add_generated_songs @generator, {@user.id => :bass}, remove_unrated: true
    end

    it "should set unrated songs to specified rating" do
      @generator.should_receive :generate do |arg|
        arg[@songs[0].id][@user.id].should eq(42)
      end

      @playlist.add_generated_songs @generator, {@user.id => :bass}, default_rating: 42
    end

    it "should set unrated songs to default rating" do
      @generator.should_receive :generate do |arg|
        arg[@songs[0].id][@user.id].should eq(3)
      end

      @playlist.add_generated_songs @generator, {@user.id => :bass}
    end

    it "should add generated songs" do
      @generator.stub(:generate).and_return([@songs[4].id, @songs[7].id])
      @playlist.add_generated_songs @generator, {@user.id => :bass}
      @playlist.songs.length.should eq(2)
      @playlist.songs.any? {|item| item.song == @songs[4]}.should eq(true)
      @playlist.songs.any? {|item| item.song == @songs[7]}.should eq(true)
    end

    it "should set the players instruments in each song" do
      @generator.stub(:generate).and_return([@songs[4].id, @songs[7].id])
      @playlist.add_generated_songs @generator, {@user.id => :bass}
      @playlist.songs.length.should eq(2)
      @playlist.songs.each do |song|
        song.bass_rocker.should eq(@user)
      end
    end

    it "should not add songs if nothing is returned" do
      @generator.stub(:generate)
      @playlist.add_generated_songs @generator, {@user.id => :bass}
      @playlist.songs.length.should eq(0)
    end

    it "should ignore 'pro' for instrument selection" do
      @generator.stub(:generate).and_return([@songs[4].id, @songs[7].id])
      @playlist.add_generated_songs @generator, {@user.id => :pro_bass}
      @playlist.songs.length.should eq(2)
      @playlist.songs.each do |song|
        song.bass_rocker.should eq(@user)
      end
    end

    it "should only use filtered songs" do
      @generator.should_receive :generate do |arg|
        arg.keys.should include(@songs[2].id)
        arg.keys.should include(@songs[4].id)
        arg.keys.should include(@songs[9].id)
        arg.keys.length.should eq(3)
      end

      genres = [@songs[2].genre, @songs[4].genre, @songs[9].genre]
      @playlist.add_generated_songs @generator, {@user.id => :bass} do |song|
        genres.include? song.genre
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