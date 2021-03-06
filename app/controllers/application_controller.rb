class ApplicationController < ActionController::Base
  protect_from_forgery

  INSTRUMENTS = [:guitar, :bass, :drums, :keyboard, :vocals]
  INSTRUMENTS_WITH_PRO = [:guitar, :pro_guitar, :bass, :pro_bass,
                          :drums, :pro_drums, :keyboard, :pro_keyboard,
                          :vocals, :pro_vocals]

  def prepare_song_list
    @owned_songs = current_user.songs
    @rated_songs = current_user.ratings

    @song = Song.first
    @rating = @song.ratings.build user: current_user
  end

  def get_other_users
    @users = User.where(['id <> ?', current_user.id])
  end
end
