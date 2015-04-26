class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  #helper method current_user is defined here so that all controllers will have access to it.
  helper_method :current_user
  #set time zone to Pacific time for the strftime method.
  Time.zone = "Pacific Time (US & Canada)"
	
	private 
	def current_user #helper method that helps with identifying whether a user is logged in.
	  @current_user ||= User.find(session[:user_id]) if session[:user_id]
	end
end #end of class


	