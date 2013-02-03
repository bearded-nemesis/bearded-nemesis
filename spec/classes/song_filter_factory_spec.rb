require "spec_helper"

describe SongFilterFactory do
  describe "genre filters" do
    before :each do
      @params = { "filter_index" => "0",
                  "filter[0].type" => "genre",
                  "filter[0].genre" => "rock" }
    end

    it "should return a genre filter" do
      factory = SongFilterFactory.new
      filters = factory.create_filters @params
      filters.length.should eq(1)
      filters[0].class.name.should eq("GenreFilter")
    end

    it "should populate the genre filter" do
      factory = SongFilterFactory.new
      filters = factory.create_filters @params.merge("filter[0].genre" => "rock, jazz")
      filters.length.should eq(1)
      filters[0].genre.should include("rock", "jazz")
    end
  end

  describe "difficulty filters" do
    before :each do
      @params = { "filter_index" => "0",
                  "filter[0].instrument" => "bass",
                  "filter[0].low" => "2",
                  "filter[0].high" => "4",
                  "filter[0].type" => "difficulty" }
    end

    it "should return a difficulty filter" do
      factory = SongFilterFactory.new
      filters = factory.create_filters @params
      filters.length.should eq(1)
      filters[0].class.name.should eq("SongDifficultyFilter")
    end

    it "should populate the difficulty filter" do
      factory = SongFilterFactory.new
      filters = factory.create_filters @params
      filters[0].instrument.should eq(:bass)
      filters[0].low.should eq(2)
      filters[0].high.should eq(4)
    end

    it "should create two filters" do
      opts = @params.merge "filter_index" => "0,2",
                           "filter[2].instrument" => "pro_drums",
                           "filter[2].low" => "1",
                           "filter[2].high" => "3",
                           "filter[2].type" => "difficulty"

      factory = SongFilterFactory.new
      filters = factory.create_filters opts
      filters.length.should eq(2)
      filters[0].instrument.should eq(:bass)
      filters[1].instrument.should eq(:pro_drums)
      filters[1].low.should eq(1)
      filters[1].high.should eq(3)
    end
  end
end