class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  def index
    @projects = Projects.all
  end

  def show
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      redirect_to project_path(@project)
    else
      @project
      render :new
    end
  end

  def edit
  end

  def update
    if @project.update(project_params)
      redirect_to project_path(@project)
    else
      render :show
    end
  end

  def destroy
    @project.destroy
    reidrect_to projects_path
  end

private
  def set_project
    @project = Post.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:title, :description, :tag_ids => [])
  end
end
