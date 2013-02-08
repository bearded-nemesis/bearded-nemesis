class SongFilterFactory
  def create_filters(params)
    params["filter_index"].split(",").map do |n|
      filter_params = params["filter"]["#{n}"]
      type = filter_params["type"]
      filter = build_genre_filter(filter_params) if type == "genre"
      filter = build_difficulty_filter(filter_params) if type == "difficulty"
      filter
    end.select {|item| !item.nil?}
  end

  def build_difficulty_filter(params)
    return nil if params["instrument"].nil? or params["instrument"].empty?
    instrument = params["instrument"].to_sym
    low = params["low"].to_i
    high = params["high"].to_i
    SongDifficultyFilter.new instrument, low: low, high: high
  end

  def build_genre_filter(params)
    return nil unless params["genre"]
    genres = params["genre"].map {|item| item.strip }
    GenreFilter.new genres
  end
end