class AdsController < ApplicationController

  load_and_authorize_resource
  before_filter :create_sections, :only => [:new,:edit,:update,:create]

  def index
    @search = @ads.with_state(:publish).search(params[:q])
    @ads = @search.result.includes(:user,:section).page(params[:page]).per(5)
    @search.build_condition if @search.conditions.empty?
    @search.build_sort if @search.sorts.empty?
  end

  def show
    @images = Asset.find_all_by_ad_id(@ad.id)
  end

  def new
  end

  def edit
  end

  def create
    @ad.user_id = current_user.id
    if @ad.save
      redirect_to manage_ads_path, notice: 'Ad was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    @ad.user_id = current_user.id
    if @ad.update_attributes(params[:ad])
      redirect_to manage_ads_path, notice: 'Ad was successfully updated.'
    else
      render action: "edit"
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
    @ads = Ad.accessible_by(current_ability,:manager).includes(:user,:section).page(params[:page]).per(5)
  end

  def destroy
    if params[:ad_ids]
     @ads = Ad.find(params[:ad_ids])
     @ads.map(&:destroy)
    end
    redirect_to manage_ads_path, notice: "Ads destroyed"
  end

  private
  def create_sections
    @sections = Section.order(:name)
  end
end
