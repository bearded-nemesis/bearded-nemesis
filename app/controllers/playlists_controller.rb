class PlaylistsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :load_playlist, except: [:index, :new, :create]
  before_filter :get_other_users, except: [:index, :show]

  # GET /playlists
  # GET /playlists.json
  def index
    @playlists = Playlist.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @playlists }
    end
  end

  # GET /playlists/1
  # GET /playlists/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @playlist }
    end
  end

  # GET /playlists/new
  # GET /playlists/new.json
  def new
    @playlist = Playlist.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @playlist }
    end
  end

  # GET /playlists/1/edit
  def edit
  end

  # POST /playlists
  # POST /playlists.json
  def create
    @playlist = Playlist.new(params[:playlist].merge(user: current_user))

    # Add players to playlist
    if params[:players]
      params[:players].each do |user_id|
        user = User.find(user_id)
        @playlist.users << user
      end
    end

    respond_to do |format|
      if @playlist.save
        format.html { redirect_to @playlist, notice: 'Playlist was successfully created.' }
        format.json { render json: @playlist, status: :created, location: @playlist }
      else
        format.html { render action: "new" }
        format.json { render json: @playlist.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /playlists/1
  # PUT /playlists/1.json
  def update
    # Remove all songs and add the ones being submitted via post
    @playlist.songs.delete_all

    if params[:songs]
      params[:songs].each do |song_id|
        song = Song.find(song_id)

        playlist_song = PlaylistSong.new
        playlist_song.song = song

        @playlist.songs << playlist_song
      end
    end

    # Remove all players and add the ones being submitted via post
    @playlist.users.delete_all

    if params[:players]
      params[:players].each do |user_id|
        user = User.find(user_id)
        @playlist.users << user
      end
    end

    respond_to do |format|
      if @playlist.update_attributes(params[:playlist])
        format.html { redirect_to @playlist, notice: 'Playlist was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @playlist.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /playlists/1
  # DELETE /playlists/1.json
  def destroy
    @playlist.destroy

    respond_to do |format|
      format.html { redirect_to playlists_url }
      format.json { head :no_content }
    end
  end

  def play
    render :layout => "mobile"
  end

  def auto
    @genres = Song.uniq.pluck :genre
  end

  def generate
    options = {
      remove_unrated: (not params[:include_unrated]),
      default_rating: params[:default_rating]
    }
    player_instruments = {}
    params.keys.map do |key|
      if (match = /instrument_(\d*)/.match key)
        player_instruments[match[1].to_i] = params[key].to_sym
      end
    end

    player_instruments.delete_if { |item| item.nil? }
    song_count = params[:song_count].to_i

    generator = SongSelector.new song_count

    @playlist.add_generated_songs generator, player_instruments, options do |song|
      params[:genre_filter] ? params[:genre_filter].include?(song.genre) : true
    end
    @playlist.save

    redirect_to playlist_path(@playlist)
  end

  private

  def load_playlist
    @playlist = Playlist.find(params[:id])
  end
end
