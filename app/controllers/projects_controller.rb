class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  def index
    @projects = Projects.all
    respond_to do |format|
      format.html {render :index}
      format.json {render json: @projects}
    end
  end

  def show
  end

  def new
    @project = Project.new
    @project.messages.build
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
    end
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
    @project = Post.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:title, :description, :tag_names, :tag_ids => [])
  end
end
