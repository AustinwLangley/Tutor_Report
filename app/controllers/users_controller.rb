class UsersController < ApplicationController
	def index #this action lists all users.  
		@users = User.all
	end

	def show #this actions shows a particular record of an user.  
		@user = User.find(params[:id])
		@report = Report.new
	end

	def new #this action is the first half of createing a new user.  
    	@user = User.new
    	@report = Report.new
 	end

	def create #records the new user into the database.  
	  @user = User.new(params.require(:user).permit(:name, :email, :password, :password_confirmation))
	  if @user.save  #if the record saves, create a cookie, flash a welcome message and redirect to the new report view.  
	  	session[:user_id] = @user.id.to_s
	  	flash[:welcome] = "Thanks for signing up, #{@user.name}!"
	    redirect_to new_report_path(@user)
  	else
    	render :new
  	end
  end
end #end of controller
