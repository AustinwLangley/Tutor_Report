class UsersController < ApplicationController
	
  	attr_reader :password #add this line right below our list of fields

	  #we also need to create an @password instance variable and set it's value in our setter method
	  def password=(unencrypted_password)
	    unless unencrypted_password.empty?
	    @password = unencrypted_password
	    self.password_digest = BCrypt::Password.create(unencrypted_password)
    end
  end

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
	  @user = User.new(params.require(:user).permit(:name, :email, :password, :password_confirmation))
	  if @user.save
	  	session[:user_id] = @user.id.to_s
	    redirect_to new_report_path(@user)
  	else
    	render :new
  	end
  end
end
