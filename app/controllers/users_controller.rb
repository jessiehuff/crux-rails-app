class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def index
    @users = User.all
  end

private
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
