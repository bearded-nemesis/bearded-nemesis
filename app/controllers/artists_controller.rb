class ArtistsController < ApplicationController
  def index
    @artists = Song.uniq.pluck :artist
  end

  def show
    @artist = params[:name]
    @songs = Song.paginate(:page => params[:page], :per_page => 100).find_all_by_artist @artist
    prepare_song_list
  end
end
