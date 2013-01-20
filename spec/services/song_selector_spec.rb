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
end