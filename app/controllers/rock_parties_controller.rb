class RockPartiesController < ApplicationController
  # GET /rock_parties
  # GET /rock_parties.json
  def index
    @rock_parties = RockParty.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @rock_parties }
    end
  end

  # GET /rock_parties/1
  # GET /rock_parties/1.json
  def show
    @rock_party = RockParty.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @rock_party }
    end
  end

  # GET /rock_parties/new
  # GET /rock_parties/new.json
  def new
    @rock_party = RockParty.new
    @users = User.where(['id <> ?', current_user.id])

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @rock_party }
    end
  end

  # GET /rock_parties/1/edit
  def edit
    @rock_party = RockParty.find(params[:id])
    @users = User.where(['id <> ?', current_user.id])
  end

  # POST /rock_parties
  # POST /rock_parties.json
  def create
    @rock_party = RockParty.new(params[:rock_party].merge(user: current_user))

    # Add attendees to rock party
    if params[:attendees]
      params[:attendees].each do |user_id|
        user = User.find(user_id)
        @rock_party.users << user
      end
    end

    respond_to do |format|
      if @rock_party.save
        format.html { redirect_to @rock_party, notice: 'Rock party was successfully created.' }
        format.json { render json: @rock_party, status: :created, location: @rock_party }
      else
        format.html { render action: "new" }
        format.json { render json: @rock_party.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /rock_parties/1
  # PUT /rock_parties/1.json
  def update
    @rock_party = RockParty.find(params[:id])

    # Remove all attendees and add the ones being submitted via post
    @rock_party.users.delete_all

    if params[:attendees]
      params[:attendees].each do |user_id|
        user = User.find(user_id)
        @rock_party.users << user
      end
    end
    
    respond_to do |format|
      if @rock_party.update_attributes(params[:rock_party])
        format.html { redirect_to @rock_party, notice: 'Rock party was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @rock_party.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rock_parties/1
  # DELETE /rock_parties/1.json
  def destroy
    @rock_party = RockParty.find(params[:id])
    @rock_party.destroy

    respond_to do |format|
      format.html { redirect_to rock_parties_url }
      format.json { head :no_content }
    end
  end
end
