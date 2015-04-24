class SessionsController < ApplicationController
  def new
  end
  def create
    user = User.where(email: params[:login][:email]).first
    if user && user.authenticate(params[:login][:password])
      session[:user_id] = user.id.to_s
      redirect_to new_report_path
    else
      flash.now[:error] = "Your email address or password are incorrect."
      render :new
    end
  end
  def destroy
    session.delete(:user_id)
    redirect_to login_path
  end
end
