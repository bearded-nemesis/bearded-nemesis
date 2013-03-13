class PlaylistPlayerController < ApplicationController
  before_filter :authenticate_user!

  def index
    playlist = Playlist.find params[:playlist_id]
puts playlist
puts playlist.players
    foo = playlist.players.map do |player|
      { id: player.user.id,
        name: player.user.name,
        email: player.user.email,
        default_instrument: player.default_instrument } if player.user
    end

puts foo

    respond_to do |format|
      format.json do
        render json: foo
      end
    end
  end
end
