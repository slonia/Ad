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
    if @section.save
      redirect_to @section, notice: 'Section was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    if @section.update_attributes(params[:section])
      redirect_to @section, notice: 'Section was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @section.destroy
    redirect_to sections_url
  end
end
