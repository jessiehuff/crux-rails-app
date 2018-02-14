class SessionsController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.from_omniauth(auth)
    if @user.errors.any?
      redirect_to new_user_registration_path
    else
      session[:user_id] = @user.id
      redirect_to root_path
    end
  end

  def destroy 
    if user_signed_in?
      session.delete :user_id 
      flash[:message] = "You have successfully logged out."
    end 
    redirect_to root_path
  end 

  def auth
    request.env['omniauth.auth']
  end
end
