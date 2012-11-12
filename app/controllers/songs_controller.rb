class SongsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :get_song, except: [:index, :mine, :new, :create]

  # GET /songs
  # GET /songs.json
  def index
    @songs = Song.includes(:ratings, :users)
      .where("(ratings.user_id IS NULL OR ratings.user_id = ?)",
             current_user.id)
    @owned_songs = current_user.songs

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @songs }
    end
  end

  def mine
    @songs = Song.includes(:ratings, :users)
    .where("(ratings.user_id IS NULL OR ratings.user_id = ?) AND (songs_users.user_id = ?)",
           current_user.id, current_user.id)

    respond_to do |format|
      format.html { render action: "index" }
      format.json { render json: @songs }
    end
  end

  # GET /songs/1
  # GET /songs/1.json
  def show
    @ratings = Rating.where(song_id: @song.id, user_id: current_user.id).first
    @is_owned = current_user_owns_song

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @song }
    end
  end

  # GET /songs/new
  # GET /songs/new.json
  def new
    @song = Song.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @song }
    end
  end

  # GET /songs/1/edit
  def edit
  end

  # POST /songs
  # POST /songs.json
  def create
    @song = Song.new(params[:song])

    respond_to do |format|
      if @song.save
        format.html { redirect_to @song, notice: 'Song was successfully created.' }
        format.json { render json: @song, status: :created, location: @song }
      else
        format.html { render action: "new" }
        format.json { render json: @song.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /songs/1
  # PUT /songs/1.json
  def update
    respond_to do |format|
      if @song.update_attributes(params[:song])
        format.html { redirect_to @song, notice: 'Song was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @song.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /songs/1
  # DELETE /songs/1.json
  def destroy
    @song.destroy

    respond_to do |format|
      format.html { redirect_to songs_url }
      format.json { head :no_content }
    end
  end

  def own
    if params[:does_own]
      @song.users << current_user unless current_user_owns_song
    else
      @song.users.delete current_user if current_user_owns_song
    end

    respond_to do |format|
      if @song.save
        format.html { redirect_to @song, notice: 'Saved.' }
        format.json { render json: @song, status: :saved, location: @song }
      else
        format.html { redirect_to @song }
        format.json { render json: @song.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def current_user_owns_song
    @song.users.exists? current_user
  end

  def get_song
    @song = Song.find params[:id]
  end
end
