require "spec_helper"

describe SongFilterFactory do
  describe "genre filters" do
    before :each do
      @params = { "filter_index" => "0",
                  "filter" => {"0" => {"type" => "genre",
                                       "genre" => ["rock"] }}}
    end

    it "should return a genre filter" do
      factory = SongFilterFactory.new
      filters = factory.create_filters @params
      filters.length.should eq(1)
      filters[0].class.name.should eq("GenreFilter")
    end

    it "should populate the genre filter" do
      factory = SongFilterFactory.new
      @params["filter"]["0"]["genre"] = ["rock", "jazz"]
      filters = factory.create_filters @params
      filters.length.should eq(1)
      filters[0].genre.should include("rock", "jazz")
    end

    it "should not return a genre filter if the genre field does not exist" do
      factory = SongFilterFactory.new
      @params["filter"]["0"]["genre"] = nil
      filters = factory.create_filters @params
      filters.length.should eq(0)
    end
  end

  describe "difficulty filters" do
    before :each do
      @params = { "filter_index" => "0",
                  "filter" => {"0" => {"type" => "difficulty",
                                       "instrument" => "bass",
                                       "low" => "2",
                                       "high" => "4" }}}
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

    it "should not return filter when instrument is empty" do
      factory = SongFilterFactory.new
      @params["filter"]["0"]["instrument"] = ""
      filters = factory.create_filters @params
      filters.length.should eq(0)
    end

    it "should create two filters" do
      @params["filter_index"] = "0,2"
      @params["filter"]["2"] = {
          "type" => "difficulty",
          "instrument" => "pro_drums",
          "low" => "1",
          "high" => "3"
      }

      factory = SongFilterFactory.new
      filters = factory.create_filters @params
      filters.length.should eq(2)
      filters[0].instrument.should eq(:bass)
      filters[1].instrument.should eq(:pro_drums)
      filters[1].low.should eq(1)
      filters[1].high.should eq(3)
    end
  end
end