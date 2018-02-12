class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show]
  before_action :set_user, only: [:show, :edit, :update]

  def new
    @user = User.new
  end

  def create
    if auth
      @user = User.find_or_create_by(uid: auth['uid']) do |u|
        u.name = auth['info']['name']
        u.email = auth['info']['email']
        u.image = auth['info']['image']
      end
      session[:user_id] = @user.id
      redirect_to home_url
    else
      @user = User.new(user_params)
      if @user.save
        session[:user_id] = @user.id
        redirect_to home_path
      else
        render :new
      end
    end
  end

  def show
    render :not_found if !@user
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:message] = "Information updated!"
      redirect_to @user
    else
      render :edit
    end
  end

private
  def user_params
    params.require(:user).permit(:name, :email, :password)
  end

  def auth
    request.env['omniauth.auth']
  end
end
