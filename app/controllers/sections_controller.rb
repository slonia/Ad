class SectionsController < ApplicationController

  load_and_authorize_resource

  def index
    @sections = @sections.order(:name).page(params[:page]).per(10)
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    respond_to do |format|
      if @section.save
        format.html { redirect_to @section, notice: 'Section was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def update
    respond_to do |format|
      if @section.update_attributes(params[:section])
        format.html { redirect_to @section, notice: 'Section was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    @section.destroy
    redirect_to sections_url
  end
end
