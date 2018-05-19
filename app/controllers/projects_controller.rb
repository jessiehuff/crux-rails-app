class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  def index
    if params[:search]
      @projects = Project.search(params[:search]).order("created_at DESC")
      if params[:search] == ""
        @projects = Project.all
      end
    else
      @projects = Project.all
    end

    respond_to do |format| 
      format.html {render :index}
      format.json {render json: @projects}
    end
  end

  def show
    @messages = @project.messages
    @tasks = @project.tasks

    respond_to do |format| 
      format.html {render :show}
      format.json {render json: @project}
    end 
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
      redirect_to @project
    else
      render :action => 'edit'
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
