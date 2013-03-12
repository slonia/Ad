class ApplicationController < ActionController::Base
	protect_from_forgery
	rescue_from CanCan::AccessDenied do |exception|
  	flash[:error] = "Access denied"
  	redirect_to root_url
	end

	def after_sign_in_path_for(resource)
    manage_ads_path
	end

end
