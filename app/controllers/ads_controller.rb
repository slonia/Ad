class AdsController < ApplicationController
  # GET /ads
  # GET /ads.json
  load_and_authorize_resource
  before_filter :create_sections
  def index
    @search = Ad.with_state(:publish).search(params[:q])
    @ads = @search.result.page(params[:page]).per(5)
    @search.build_condition if @search.conditions.empty?
    @search.build_sort if @search.sorts.empty?
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @ads }
    end
  end
  # GET /ads/1
  # GET /ads/1.json
  def show
    @images = Asset.find_all_by_ad_id(@ad.id)
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @ad }
    end
  end

  # GET /ads/new
  # GET /ads/new.json
  def new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @ad }
    end
  end

  # GET /ads/1/edit
  def edit
  end

  # POST /ads
  # POST /ads.json
  def create
    @ad.user_id = current_user.id
    respond_to do |format|
      if @ad.save
        format.html { redirect_to manage_ads_path, notice: 'Ad was successfully created.' }
        format.json { render json: @ad, status: :created, location: @ad }
      else
        format.html { render action: "new" }
        format.json { render json: @ad.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /ads/1
  # PUT /ads/1.json
  def update

    respond_to do |format|
      if @ad.update_attributes(params[:ad])
        format.html { redirect_to manage_ads_path, notice: 'Ad was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @ad.errors, status: :unprocessable_entity }
      end
    end
  end

  Ad.state_machine.states.map(&:name).each do |method|
    define_method method do
      @ads = Ad.find(params[:ad_ids])
      @ads.each do |ad|
        ad.send(method)
      end
      redirect_to manage_ads_path, notice: "Change ads state to '"+method.to_s+"'"
    end
  end

  def manager
    if current_user.role.user?
      @ads = Ad.where(:user_id => current_user.id).page(params[:page]).per(5)
    elsif current_user.role.admin?
      @ads = Ad.without_state(:draft).page(params[:page]).per(5)
    end
  end

  def destroy
    if params[:ad_ids]
     @ads = Ad.find(params[:ad_ids])
     @ads.each{ |ad| ad.destroy }
    end
    respond_to do |format|
      format.html { redirect_to manage_ads_path, notice: "Ads destroyed" }
      format.json { head :no_content }
    end
  end

  private
  def create_sections
    @sections = Section.order(:name)
  end
end
