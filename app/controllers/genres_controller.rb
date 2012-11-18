class GenresController < ApplicationController
  def index
    @genres = Song.uniq.pluck :genre
  end

  def show
    @genre = params[:name]
    @songs = Song.paginate(:page => params[:page], :per_page => 100).find_all_by_genre @genre
    prepare_song_list
  end
end
