class AdsController < ApplicationController
  # GET /ads
  # GET /ads.json
  load_and_authorize_resource
  def index
    @search = Ad.with_state(:publish).search(params[:q])
    @ads = @search.result.page(params[:page]).per(4)
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
    @sections = Section.order(:name)
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @ad }
    end
  end

  # GET /ads/1/edit
  def edit
    @sections = Section.order(:name)
  end

  # POST /ads
  # POST /ads.json
  def create
    @sections = Section.order(:name)
    respond_to do |format|
      if @ad.save
        format.html { redirect_to manage_path, notice: 'Ad was successfully created.' }
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
        format.html { redirect_to @ad, notice: 'Ad was successfully updated.' }
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
      redirect_to manage_path
    end
  end

  def destroy
    @ads = Ad.find(params[:ad_ids])
    @ads.each do |ad|
      ad.destroy
    end
    respond_to do |format|
      format.html { redirect_to manage_path }
      format.json { head :no_content }
    end
  end
end