class GenresController < ApplicationController
  def index
    @genres = Song.uniq.pluck :genre
  end

  def show
    @genre = params[:name]
    @songs = Song.find_all_by_genre @genre
    prepare_song_list
  end
end
