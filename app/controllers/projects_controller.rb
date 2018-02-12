class ProjectsController < ApplicationController

  def index
    @projects = Projects.all
  end

  def show
    @project = Project.find_by(id: params[:id])
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
    @project = Project.find_by(id: params[:id])
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
  def project_params
    params.require(:project).permit(:title, :description)
  end
end
