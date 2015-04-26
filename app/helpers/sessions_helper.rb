module SessionsHelper
	def logged_in? #Helper method that allows us to check if there is user logged in before displaying views.
	  session[:user_id] != nil
	end
end
