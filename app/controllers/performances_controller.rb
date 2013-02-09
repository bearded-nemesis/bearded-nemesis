class PerformancesController < ApplicationController
  before_filter :authenticate_user!
  skip_before_filter  :verify_authenticity_token, only: [:rate]

  def show
    playlist = Playlist.find params[:id]
    songs = playlist.songs.select{ |s| s.instrument_for current_user }.map do |item|
      instrument = item.instrument_for(current_user)

      rating = current_user.ratings.where(song_id: item.song).first

      {
          name: item.song.name,
          artist: item.song.artist,
          id: item.song.id,
          instrument: instrument,
          rating: rating ? { id: rating.id, value: rating.send(instrument.to_sym) } : {}
      }
    end

    respond_to do |format|
      format.html
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
    rating = current_user.ratings.where(song_id: song.song).first
    rating ||= current_user.ratings.build song: song.song
    rating.send "#{song.instrument_for(current_user)}=", params[:rating]
    rating.save
    render nothing: true
  end
end