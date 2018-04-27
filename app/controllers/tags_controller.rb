class TagsController < ApplicationController
  before_action :set_project, only: [:new, :create, :show, :update, :destroy]
  before_action :set_tag, only: [:show,:edit, :update, :destroy]

  def index
    @tags = Tag.all
    respond_to do |format|
      format.html { render :show }
      format.json { render json: @tags }
    end
  end

  def show
  end

  def new
    @tag = Tag.new
  end

  def create
    if @project
      @tag = Tag.new(tag_params)
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
  end

  def update
    @tag.update(tag_params)
    redirect_to tags_path
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
