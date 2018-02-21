class TagsController < ApplicationController
  before_action :set_project, only: [:new, :create, :update, :destroy]
  before_action :set_tag, only: [:update, :destroy]

  def index
    @tags = Tag.all
  end

  def new
    @tag = Tag.new
  end

  def create
    @tag = Tag.find_or_create_by(tag_params)
    if @project
      @project.tags << @tag
      @project.save
      redirect_to project_path(@project)
    elsif @tag.persisted?
      redirect_to tags_path
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

  def set_project
    @project = Project.find_by(id: params[:project_id])
  end

  def set_tag
    @tag = Tag.find_by(id: params[:id])
  end

  def tag_params
    params.require(:tag).permit(:name)
  end
end
