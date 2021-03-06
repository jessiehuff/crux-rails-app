class TasksController < ApplicationController
  before_action :set_project
  before_action :set_task, only: [:edit, :update, :show, :destroy]

  def index
    @tasks = @project.tasks
    respond_to do |format| 
      format.html {render :index}
      format.json {render json: @tasks}
    end
  end

  def new
    @task = Task.new
    render layout: false
  end

  def create
    @task = Task.new(task_params)
    project_id = params["project_id"]
    @task.project_id = project_id
    if @task.save
      @project = @task.project
      render json: @task, status: 201
    else
      flash[:message] = @task.errors.full_messages
      render json: {errors: @task.errors.full_messages}, status: 400
    end
  end

  def show
    @project = @task.project
    respond_to do |format|
      format.html {render :show}
      format.json {render json: @task}
    end 
  end

  def edit
  end

  def update
    @task.update(task_params)
    flash[:notice] = "Task updated!"
    redirect_to project_tasks_path
  end

  def destroy
    @task.destroy
    redirect_to project_tasks_path(@project)
  end

private
  def set_task
    @task = Task.find(params[:id])
  end

  def set_project
    @project = Project.find(params[:project_id])
  end

  def task_params
    params.require(:task).permit(:title, :description, :assigned_to, :status)
  end
end
