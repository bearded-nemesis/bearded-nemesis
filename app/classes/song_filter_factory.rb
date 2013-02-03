class SongFilterFactory
  def create_filters(params)
    params["filter_index"].split(",").map do |n|
      SongDifficultyFilter.new(params["filter[#{n}].instrument"].to_sym, low: params["filter[#{n}].low"].to_i, high: params["filter[#{n}].high"].to_i)
    end
  end
end