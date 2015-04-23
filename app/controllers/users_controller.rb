class UsersController < ApplicationController
	def index
		@users = User.all
	end
	def show
		@user = User.find(params[:id])
		@report = Report.new
		
	end

	def new
    	@user = User.new
    	@report = Report.new
 	end

	def create
	  @user = User.new(params.require(:user).permit(:name, :email, :password))
	  if @user.save
	    redirect_to user_path(@user)
  	else
    	render :new
  	end
  end
end
