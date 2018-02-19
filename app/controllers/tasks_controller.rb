class TasksController < ApplicationController
  before_action :set_project
  before_action :set_task, only: [:edit, :update, :show, :destroy]

  def index
    @tasks = @project.tasks
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    project_id = params["project_id"]
    @task.project_id = project_id
    if @task.save
      @project = @task.project
      redirect_to project_tasks_path(@task)
    else
      render :new
    end
  end

  def show
    @project = @task.project

  end

  def edit

  end

  def update
    @task.update(task_params)
    flash[:message] = "Task updated!"
    redirect_to project_tasks_path(@task)
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
