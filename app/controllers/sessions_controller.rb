class SessionsController < ApplicationController
  before_action :authenticate_user!, only: [:index]

private
  def sessions_params
    params.require(:user).permit(:email, :password)
  end
end 
