class HomeController < ApplicationController
  def index
    if user_signed_in?
      redirect_to projects_path
    else
      @user = User.new
      render :index
    end
  end
end
