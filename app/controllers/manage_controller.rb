class ManageController < ApplicationController
  def index
  	if current_user.role.user?
  		@ads = Ad.where(:user_id => current_user.id)
  	elsif current_user.role.admin?
  		@ads = Ad.without_state(:draft)
  	else
  		redirect_to "/", :notice => 'error'
  	end
  end
end
