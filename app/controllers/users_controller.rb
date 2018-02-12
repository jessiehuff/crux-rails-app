class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show]
  before_action :set_user, only: [:show, :edit, :update]


private
  def user_params
    params.require(:user).permit(:name, :email, :password)
  end

  def auth
    request.env['omniauth.auth']
  end
end
