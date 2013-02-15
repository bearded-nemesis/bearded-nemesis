class PlaylistsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :load_playlist, except: [:index, :new, :create]
  before_filter :get_other_users, except: [:index, :show]

  # GET /playlists
  # GET /playlists.json
  def index
    @playlists = Playlist.where(user_id: current_user)
    @playlists.concat Playlist.includes(:players).where("playlist_users.user_id" => current_user)

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

    save_songs
    save_players
    save_rock_party

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
    save_songs

    # Remove all players and add the ones being submitted via post
    @playlist.players.delete_all
    save_players

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

  end

  def auto
    @genres = Song.uniq.pluck(:genre).sort
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
    filters = SongFilterFactory.new.create_filters params

    @playlist.add_generated_songs generator, player_instruments, options do |song|
      filters.all? {|filter| filter.nil? or filter.matches? song }
    end
    @playlist.save

    redirect_to playlist_path(@playlist)
  end

  private

  def load_playlist
    @playlist = Playlist.find(params[:id])
  end

  def save_players
    if params[:players]
      params[:players].each do |user_id|
        user = User.find(user_id)
        @playlist.users << user
      end
    end
  end

  def save_rock_party
    if params[:rock_party_id]
      rock_party = RockParty.find(params[:rock_party_id])
      @playlist.rock_party = rock_party
    end
  end

  def save_songs
    if params[:songs]
      params[:songs].each do |song_id|
        position = params[:position][0] if params[:position].present?

        song = Song.find(song_id)

        playlist_song = PlaylistSong.new
        playlist_song.song = song
        playlist_song.position = position

        @playlist.songs << playlist_song
      end
    end
  end
end
