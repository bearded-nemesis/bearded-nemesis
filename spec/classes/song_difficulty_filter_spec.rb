require "spec_helper"

describe SongDifficultyFilter do
  before(:all) do
    Struct.new("DummySong", :bass_difficulty, :pro_drums_difficulty)
  end

  it "should return songs within the difficulty range" do
    songs = (0..6).map {|n| Struct::DummySong.new(n, n) }
    filter = SongDifficultyFilter.new :bass, low: 2, high: 4
    results = filter.filter songs
    results.should include(songs[2], songs[3], songs[4])
    results.length.should eq(3)
  end

  it "should use the specified instrument" do
    songs = (0..6).map {|n| Struct::DummySong.new(n, 4) }
    filter = SongDifficultyFilter.new :pro_drums, low: 2, high: 4
    results = filter.filter songs
    results.length.should eq(7)
  end

  it "should not modify the original array" do
    songs = (0..6).map {|n| Struct::DummySong.new(n, n) }
    filter = SongDifficultyFilter.new :bass, low: 2, high: 4
    filter.filter songs
    songs.length.should eq(7)
  end
end