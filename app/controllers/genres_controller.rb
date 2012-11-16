class GenresController < ApplicationController
  def index
    @genres = Song.uniq.pluck :genre
  end

  def show
    @genre = params[:name]
    @songs = Song.find_all_by_genre @genre
    @owned_songs = current_user.songs
    @rated_songs = current_user.ratings

    @song = Song.first
    @rating = @song.ratings.build user: current_user
  end
end
