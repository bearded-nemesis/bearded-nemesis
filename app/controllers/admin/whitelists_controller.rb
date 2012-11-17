class Admin::WhitelistsController < Admin::AdminController
  # GET /admin/whitelists
  # GET /admin/whitelists.json
  def index
    @admin_whitelists = Admin::Whitelist.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @admin_whitelists }
    end
  end

  # GET /admin/whitelists/1
  # GET /admin/whitelists/1.json
  def show
    @admin_whitelist = Admin::Whitelist.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @admin_whitelist }
    end
  end

  # GET /admin/whitelists/new
  # GET /admin/whitelists/new.json
  def new
    @admin_whitelist = Admin::Whitelist.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @admin_whitelist }
    end
  end

  # GET /admin/whitelists/1/edit
  def edit
    @admin_whitelist = Admin::Whitelist.find(params[:id])
  end

  # POST /admin/whitelists
  # POST /admin/whitelists.json
  def create
    @admin_whitelist = Admin::Whitelist.new(params[:admin_whitelist])

    respond_to do |format|
      if @admin_whitelist.save
        format.html { redirect_to @admin_whitelist, notice: 'Whitelist was successfully created.' }
        format.json { render json: @admin_whitelist, status: :created, location: @admin_whitelist }
      else
        format.html { render action: "new" }
        format.json { render json: @admin_whitelist.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /admin/whitelists/1
  # PUT /admin/whitelists/1.json
  def update
    @admin_whitelist = Admin::Whitelist.find(params[:id])

    respond_to do |format|
      if @admin_whitelist.update_attributes(params[:admin_whitelist])
        format.html { redirect_to @admin_whitelist, notice: 'Whitelist was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @admin_whitelist.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/whitelists/1
  # DELETE /admin/whitelists/1.json
  def destroy
    @admin_whitelist = Admin::Whitelist.find(params[:id])
    @admin_whitelist.destroy

    respond_to do |format|
      format.html { redirect_to admin_whitelists_url }
      format.json { head :no_content }
    end
  end
end
