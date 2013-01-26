class PerformancesController < ApplicationController
  before_filter :authenticate_user!

  def show
    playlist = Playlist.find params[:id]

    songs = playlist.songs.map do |item|
      instrument = item.instrument_for(current_user)
      rating = current_user.ratings.where(user_id: item).first
      {
          name: item.song.name,
          id: item.song.id,
          instrument: instrument,
          rating: rating ? { id: rating.id, value: rating.send(instrument.to_sym) } : {}
      }
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json {
        render json: {
          name: playlist.name,
          id: playlist.id,
          songs: songs
        }
      }
    end
  end

  def rate
    playlist = Playlist.find params[:id]
    song = playlist.songs.where(song_id: params[:song]).first
    rating = current_user.ratings.build song: song.song
    rating.send "#{song.instrument_for(current_user)}=", params[:rating]
    rating.save
    render nothing: true
  end
end