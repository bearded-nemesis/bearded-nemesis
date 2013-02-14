class PlaylistSongController < ApplicationController
  before_filter :authenticate_user!
  protect_from_forgery :except => [:create]

  # PUT /playlistsong
  # PUT /playlistsong.json
  def update
    playlist_song = PlaylistSong.find params[:id]
    user = User.find params[:player]

    ApplicationController::INSTRUMENTS_WITH_PRO.each do |instr|
      if params[:instrument] == instr.to_s
        playlist_song.send("#{params[:instrument]}_rocker=", user)
      elsif playlist_song.send("#{instr}_rocker") == user
        playlist_song.send("#{instr}_rocker=", nil)
      end
    end

    if playlist_song.save
      render json: playlist_song, status: :ok, location: playlist_song
    else
      render json: playlist_song.errors, status: :unprocessable_entity
    end
  end

  def create
    playlist = Playlist.find params[:playlist_id]
    song = Song.find params[:song_id]
    association = playlist.songs.create song: song
    playlist.save
    render json: association
  end

  # DELETE /playlistsong/1
  # DELETE /playlistsong/1.json
  def destroy
    playlist_song = PlaylistSong.find params[:id]
    playlist = playlist_song.playlist

    playlist_song.destroy

    respond_to do |format|
      format.html { redirect_to playlist_url playlist }
      format.json { head :no_content }
    end
  end
end
