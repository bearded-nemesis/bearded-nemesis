require "spec_helper"

describe GenreFilter do
  before(:all) do
    Struct.new("DummyGenreSong", :genre)
    @songs = %w[rock jazz rock alternative].map {|n| Struct::DummyGenreSong.new n }
  end

  it "should return songs with specified genre" do
    filter = GenreFilter.new "rock"
    results = filter.filter @songs
    results.length.should eq(2)
    results.should include(@songs[0], @songs[2])
  end

  it "should return genre case" do
    filter = GenreFilter.new "RoCk"
    results = filter.filter @songs
    results.length.should eq(2)
    results.should include(@songs[0], @songs[2])
  end

  it "should return songs with multiple genres" do
    filter = GenreFilter.new %w(jazz alternative)
    results = filter.filter @songs
    results.length.should eq(2)
    results.should include(@songs[1], @songs[3])
  end

  it "should exclude songs with nil genres" do
    new_songs = @songs + [Struct::DummyGenreSong.new(nil)]
    filter = GenreFilter.new "Rock"
    results = filter.filter new_songs
    results.length.should eq(2)
  end
end