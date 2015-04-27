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

  	def edit #This action is the first part of editing a page.  "retrives a single record"
		@user = User.find(params[:id]) 
	end

	def update #this action saves the change in the database.
  	@user = User.find(params[:id]) #retrives a single record
	  if @user.update_attributes(params.require(:user).permit(:name, :email, :password, :password_confirmation, :role))  #If a record is successfully updated, redirect to the users index.
	  	flash[:welcome] = "Your changes have been saved."  
	  	redirect_to new_report_path(@user)
	  else
	    render :edit  #If a record is not successfully updated, render a new edit form.
	  end
	end

  	def destroy #this action destroys a single record.
	  @user = User.find(params[:id])
	  @user.destroy
	  redirect_to users_path  #redirects to the report index.  
	end

  	
end #end of controller
