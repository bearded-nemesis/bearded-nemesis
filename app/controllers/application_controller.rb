class ApplicationController < ActionController::Base
  protect_from_forgery

  def prepare_song_list
    @owned_songs = current_user.songs
    @rated_songs = current_user.ratings

    @song = Song.first
    @rating = @song.ratings.build user: current_user
  end
end
