class SongDifficultyFilter
  attr_reader :instrument, :low, :high

  def initialize(instrument, options)
    @instrument = instrument
    @low = options[:low]
    @high = options[:high]
  end

  def filter(songs)
    songs.select {|song| matches? song}
  end

  def matches?(song)
    song.send("#{@instrument}_difficulty").between? @low, @high
  end
end