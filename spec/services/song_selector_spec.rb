require "spec_helper"

describe SongSelector do
  it "should generate a song list" do
    ratings = {
      1 => { 10 => 4, 13 => 5 },
      2 => { 10 => 3, 13 => 3 }
    }

    selector = SongSelector.new 1
    songs = selector.generate ratings
    songs.should include(1)
    songs.length.should eq(1)
  end

  it "should return an empty array if no ratings are entered" do
    selector = SongSelector.new 1
    songs = selector.generate nil
    songs.should be_empty
  end

  it "should return an empty array if ratings have no players" do
    selector = SongSelector.new 1
    songs = selector.generate({ 1 => nil })
    songs.should be_empty
  end

  it "should return an empty array if there are no available songs" do
    selector = SongSelector.new 1
    songs = selector.generate({ })
    songs.should be_empty
  end
end