class SongFilterFactory
  def create_filters(params)
    params["filter_index"].split(",").map do |n|
      type = params["filter[#{n}].type"]
      filter = build_genre_filter(n, params) if type == "genre"
      filter = build_difficulty_filter(n, params) if type == "difficulty"
      filter
    end
  end

  def build_difficulty_filter(index, params)
    instrument = params["filter[#{index}].instrument"].to_sym
    low = params["filter[#{index}].low"].to_i
    high = params["filter[#{index}].high"].to_i
    SongDifficultyFilter.new instrument, low: low, high: high
  end

  def build_genre_filter(index, params)
    genres = params["filter[#{index}].genre"].split(",").map {|item| item.strip }
    GenreFilter.new genres
  end
end