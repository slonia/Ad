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
    if @user.save
      redirect_to @user, :notice => 'User was successfully created.'
    else
      render :action => "new"
    end
  end

  def update
    @role = params[:user][:role]
    params[:user].delete(:role)
    @user = User.find(params[:id])
    @user.role = @role if can? :assign_role, @user
    if @user.update_with_password(params[:user])
      sign_in(@user, :bypass => true) if @user == current_user
      redirect_to @user, :notice => 'User was successfully updated.'
    else
      render :action => "edit"
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_url
  end
end
