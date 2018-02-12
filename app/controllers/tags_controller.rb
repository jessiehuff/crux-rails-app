class TagsController < ApplicationController
  before_action :set_tag, only: [:update, :destroy]

  def index
    @tags = Tag.all
  end

  def show
    redirect_to tags_path
  end

  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      redirect_to tags_path
    else
      render :index
    end
  end

  def edit
    redirect_to tags_path
  end

  def update
    @tag.update(tag_params)
    reidrect_to tags_path
  end

  def destroy
    @tag.destroy
    redirect_to tags_path
  end

private
  def set_tag
    @tag = Tag.find_by(id: params[:id])
  end

  def tag_params
    params.require(:tag).permit(:name)
  end
end
