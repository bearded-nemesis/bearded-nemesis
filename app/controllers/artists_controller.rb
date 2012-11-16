class ArtistsController < ApplicationController
  def index
    @artists = Song.uniq.pluck :artist
  end

  def show
    @artist = params[:name]
    @songs = Song.find_all_by_artist @artist
    @owned_songs = current_user.songs
    @rated_songs = current_user.ratings

    @song = Song.first
    @rating = @song.ratings.build user: current_user
  end
end
