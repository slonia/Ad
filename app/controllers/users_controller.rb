class UsersController < ApplicationController

  authorize_resource

  def index
    @users = User.order(:name).page(params[:page]).per(10)
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @role = params[:user].delete(:role)
    @user = User.new(params[:user])
    @user.role = @role if can? :assign_role, @user
    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, :notice => 'User was successfully created.' }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
    @role = params[:user][:role]
    params[:user].delete(:role)
    @user = User.find(params[:id])
    @user.role = @role if can? :assign_role, @user
    respond_to do |format|
      if @user.update_with_password(params[:user])
        sign_in(@user, :bypass => true) if @user == current_user
        format.html { redirect_to @user, :notice => 'User was successfully updated.' }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_url
  end
end
