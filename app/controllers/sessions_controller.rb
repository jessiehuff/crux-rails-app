class SessionsController < ApplicationController

  def create
    @user = User.from_omniauth(auth)
    if @user.errors.any?
      redirect_to new_user_registration_path
    else
      session[:user_id] = @user.id
      redirect_to root_path
    end
  end

  def auth
    request.env['omniauth.auth']
  end
end
