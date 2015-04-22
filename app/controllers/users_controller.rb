class UsersController < ApplicationController
	def index
	end
	def show
		@user = User.find(params[:id])
	end

	def new
    	@user = User.new
 	end

	def create
	  @user = User.new(params.require(:user).permit(:name, :email))
	  if @user.save
	    redirect_to user_path(@user)
  	else
    	render :new
  	end
  end
end
