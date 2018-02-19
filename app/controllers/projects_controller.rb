class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  def index
    @projects = Project.all
    respond_to do |format|
      format.html {render :index}
      format.json {render json: @projects}
    end
  end

  def show
    @messages = @project.messages
    @tasks = @project.tasks
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
    @project.update(project_params)
    if project_params(:tag_names)
      @project.update(tag_names: project_params[:tag_names])
    else
      redirect_to project_path(@project)
    end
  end

  def destroy
    @project.destroy
    reidrect_to projects_path
  end

private
  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:title, :description, :tag_names, :tag_ids => [])
  end
end
