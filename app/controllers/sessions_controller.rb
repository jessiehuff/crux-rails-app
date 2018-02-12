class SessionsController < ApplicationController
  before_action :authenticate_user!, only: [:index]

  def new
    @user = User.new
  end

  def create
    if @user = User.find_by(email: session_params[:email])
      if @user.authenticate(session_params[:password])
        session[:user_id] = @user.id
        redirect_to home_url
      else
        @user.password_error
        render :new
      end
    else
      @user = User.new_with_email_error
      render :new
    end
  end

  def index
    @user = current_user
    @projects = Projects.all
  end

  def destroy
    if logged_in?
      session.delete :user_id
      flash[:message] = "You have successfully logged out."
    end
    redirect_to users_sign_in_url
  end

private
  def sessions_params
    params.require(:user).permit(:email, :password)
  end
end
