class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  def index
    @projects = Project.all
  end

  def show
    @messages = @project.messages
    @tasks = @project.tasks
  end

  def new
    @project = Project.new
    @project.tags.build
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
    @project.update(project_params)
    if project_params[:tags_attributes]
      @project.update(tags_attributes: project_params[:tags_attributes])
    else
      redirect_to project_path(@project)
    end
  end

  def destroy
    @project.destroy
    redirect_to projects_path
  end

private
  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:title, :description, tags_attributes: [:name], :tag_ids => [])
  end
end
