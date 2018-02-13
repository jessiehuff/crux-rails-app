class HomeController < ApplicationController
  def index
    if user_signed_in?
      render :index
    else
      @user = User.new
      render :index
    end
  end
end
