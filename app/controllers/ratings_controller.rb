class RatingsController < ApplicationController
  def new
    @song = Song.find params[:song_id]
    @rating = @song.ratings.build user: current_user
    #@rating = Rating.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @rating }
    end
  end

  # GET /songs/1/ratings/1
  # GET /songs/1/ratings/1.json
  def show
    @song = Song.find params[:song_id]
    @rating = Rating.find params[:id]

    respond_to do |format|
      format.html
      format.json { render json: @rating }
    end
  end

  def edit
    @song = Song.find params[:song_id]
    @rating = Rating.find params[:id]

    respond_to do |format|
      format.html
      format.json { render json: @rating }
    end
  end

  # POST /songs/1/ratings
  # POST /songs/1/ratings.json
  def create
    @song = Song.find params[:song_id]
    @rating = Rating.new(params[:rating].merge(user: current_user, song: @song))

    respond_to do |format|
      if @rating.save
        format.html { redirect_to @song, notice: 'Ratings were successfully created.' }
        format.json { render json: {rating: @rating, url: song_rating_path(@song, @rating, :json)}, status: :created, location: @song }
      else
        format.html { render action: "new" }
        format.json { render json: @rating.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /songs/1/ratings/1
  # PUT /songs/1/ratings/1.json
  def update
    @song = Song.find params[:song_id]
    @rating = Rating.find params[:id]

    respond_to do |format|
      if @rating.update_attributes(params[:rating])
        format.html { redirect_to @song, notice: 'Ratings were successfully updated.' }
        format.json { render json: @rating }
      else
        format.html { render action: "edit" }
        format.json { render json: @rating.errors, status: :unprocessable_entity }
      end
    end
  end
end
