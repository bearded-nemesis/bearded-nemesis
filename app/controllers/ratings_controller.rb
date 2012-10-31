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

  def edit
    @song = Song.find params[:song_id]
    @rating = Rating.find params[:id]

    respond_to do |format|
      format.html
      format.json { render json: @rating }
    end
  end

  def create
    @song = Song.find params[:song_id]
    @rating = Rating.new(params[:rating].merge(user: current_user, song: @song))

    respond_to do |format|
      if @rating.save
        format.html { redirect_to @song, notice: 'Ratings were successfully created.' }
        format.json { render json: @song, status: :created, location: @song }
      else
        format.html { render action: "new" }
        format.json { render json: @rating.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @song = Song.find params[:song_id]
    @rating = Rating.find params[:id]

    respond_to do |format|
      if @rating.update_attributes(params[:rating])
        format.html { redirect_to @song, notice: 'Ratings were successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @rating.errors, status: :unprocessable_entity }
      end
    end
  end
end
