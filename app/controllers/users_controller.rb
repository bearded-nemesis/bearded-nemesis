class UsersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :get_user, except: [:index]

  # GET /users
  # GET /users.json
  def index
    @users = User.where(['id <> ?', current_user.id])
    @friends = current_user.friends

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @friendships = Friendship.where(user_id: @user).includes(:friend)
    @friended_by = @user.inverse_friends

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def import
  end

  def do_import
    raise "Too many songs" if params[:songs].lines.count > 1000

    params[:songs].lines do |line|
      title, artist = line.split "\t"

      puts title
      puts artist

      song = Song.where "UPPER(name) = UPPER(?) AND UPPER(artist) = UPPER(?)", title.strip, artist.strip
      @user.songs << song unless song.nil?
    end

    @user.save

    redirect_to mine_songs_path
  end

  private

  def get_user
    @user = User.find(params[:id])
  end
end
