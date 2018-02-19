class TagsController < ApplicationController
  before_action :set_tag, only: [:update, :destroy]

  def index
    @tags = Tag.all
  end

  def new
    @tag = Tag.new
  end

  def create
    @tag = Tag.new(tag_params)
    project_id = params["project_id"]
    @tag.project_id = project_id
    if @tag.save
      @project = @tag.project
      redirect_to project_path(@project)
    else
      render :new
    end
  end

  def edit
    @tag = Tag.find(params[:id])
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
