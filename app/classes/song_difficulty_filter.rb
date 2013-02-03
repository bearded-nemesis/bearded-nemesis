class SongDifficultyFilter
  def initialize(instrument, options)
    @instrument = instrument
    @low = options[:low]
    @high = options[:high]
  end

  def filter(songs)
    songs.reject do |song|
      difficulty = song.send "#{@instrument}_difficulty"
      difficulty < @low or difficulty > @high
    end
  end
end