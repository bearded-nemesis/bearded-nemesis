class PlaylistsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :load_playlist, except: [:index, :new, :create]

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
    @playlist.playlist_songs.delete_all

    if params[:songs]
      params[:songs].each do |song_id|
        song = Song.find(song_id)

        playlist_song = PlaylistSong.new
        playlist_song.song = song

        @playlist.playlist_songs << playlist_song
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

  def auto

  end

  def generate

    #==========================================
    # Set up data
    #==========================================
    existing_songs = @playlist.playlist_songs.map {|song| song.song.id}
    songs = @playlist.user.songs.map {|song| song.id}.uniq - existing_songs
    players = @playlist.players
    ratings = {}

    players.each do |player|
      player_ratings = player.ratings.includes :song
      instrument = params["instrument_#{player.id}"].to_sym

      songs.each do |song|
        ratings[song] ||= {}
        rating = player_ratings.find {|rating| rating.song.id == song} || {}
        ratings[song][player.id] = rating[instrument] || 0
      end
    end

    song_count = params[:song_count].to_i





    #==========================================
    # Generate the data for the model
    #==========================================
    f = Tempfile.new('playlist')
    begin
      f.write "set songs :="
      songs.each do |song|
        f.write " #{song}\n"
      end
      f.write " ;\n"


      f.write "set players :="
      players.each do |player|
        f.write " #{player.id}"
      end
      f.write " ;\n"


      f.write "param max_songs := #{song_count};\n"


      f.write "param ratings :=\n"
      f.write "[*,*]: "
      players.each do |player|
        f.write " #{player.id}"
      end
      f.write " :=\n"

      songs.each do |song|
        f.write song
        players.each do |player|
          f.write " #{ratings[song][player.id]}"
        end
        f.write "\n"
      end
      f.write ";\n"
    ensure
      f.close
      puts f.path
      #file.unlink   # deletes the temp file
    end













    #==========================================
    # Execute the model to select songs
    #==========================================
    selected_song_ids = []

    require 'rglpk'

    problem = Glpk_wrapper.glp_create_prob
    tran = Glpk_wrapper.glp_mpl_alloc_wksp
    result = Glpk_wrapper.glp_mpl_read_model tran, "#{Rails.root}/glpk_models/playlist.mod", 1
    raise "Could not parse model" unless result == 0

    result = Glpk_wrapper.glp_mpl_read_data tran, f.path
    unless result == 0
      f.open
      while (line = f.gets)
        puts "#{line}"
      end
      f.close
      raise "Error loading data"
    end

    result = Glpk_wrapper.glp_mpl_generate tran, nil
    raise "Error generating model" unless result == 0

    Glpk_wrapper.glp_mpl_build_prob tran, problem



#row_count = Glpk_wrapper.glp_get_num_cols problem

#for i in 1..row_count
#  puts Glpk_wrapper.glp_get_col_name problem, i
#end

#puts row_count







    Glpk_wrapper.glp_simplex problem, nil
    Glpk_wrapper.glp_intopt problem, nil

    #result = Glpk_wrapper.glp_mpl_postsolve tran, problem, Rglpk::GLP_SOL
    #raise "Error postsolving model" unless result == 0

    #glp_get_row_prim
    #glp_get_col_prim


    row_count = Glpk_wrapper.glp_get_num_cols problem
#
    for i in 1..row_count
      name = Glpk_wrapper.glp_get_col_name problem, i
      value = Glpk_wrapper.glp_get_col_prim problem, i

      if value.to_i == 1 and (match = /selected_songs\[([0-9]+)\]/.match name)
        print name + "\n"
        selected_song_ids << match[1].to_i
      end
      #puts name
      #puts Glpk_wrapper.glp_get_col_prim problem, i
    end

    #puts row_count


    Glpk_wrapper.glp_mpl_free_wksp tran
    Glpk_wrapper.glp_delete_prob problem








    # Remove the tempfile
    f.unlink






    #==========================================
    # Add selected songs to the playlist
    #==========================================
    selected_songs = Song.find selected_song_ids

    selected_songs.each do |song|
      playlist_song = PlaylistSong.new song: song
      playlist_song.song = song

      @playlist.playlist_songs << playlist_song
    end
    #@playlist.songs << selected_songs
    @playlist.save





    redirect_to playlist_path(@playlist)
  end

  private

  def load_playlist
    @playlist = Playlist.find(params[:id])
  end
end
