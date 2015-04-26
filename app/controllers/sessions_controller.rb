class SessionsController < ApplicationController
  def new #this action renders the login page.
  end
  def create
    #Query the data base to find a record that matches the data entered into the login form.  
    user = User.where(email: params[:login][:email]).first
    if user && user.authenticate(params[:login][:password])
      # make a new key in our session object called :user_id
      # which gets stored in a cookie on our hard drive
      session[:user_id] = user.id.to_s # This is a cookie  
      redirect_to new_report_path
    else
      #flashes an error and redirects to the login page for a re-attempt.  
      flash.now[:error] = "Your email address or password are incorrect."
      render :new
    end
  end
  def destroy  #this action ends the session and redirects to the login page. 
    session.delete(:user_id)
    redirect_to login_path
  end
end #end of sessions controller
