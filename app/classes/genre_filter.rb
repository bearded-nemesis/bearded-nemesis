class GenreFilter
  attr_reader :genre

  def initialize(genre)
    @genre = [genre].flatten.map {|item| item.downcase}
  end

  def filter(songs)
    songs.select {|song| matches? song}
  end

  def matches?(song)
    song.genre and @genre.include? song.genre.downcase
  end
end