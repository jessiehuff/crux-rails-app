class TasksController < ApplicationController
  before_action :set_project, except: [:show, :edit]
  before_action :set_task, only: [:edit, :update, :show, :destroy]

  def index
    @tasks = @project.tasks
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(project_id: @project.id)
    if @task.save
      @project = @task.project
      redirect_to task_path(@task)
    else
      render :new
      #binding.pry
    end
  end

  def show
    @project = @task.project
    @task = project.tasks.find(params[:id])
  end

  def edit
    @task = project.tasks.find(params[:id])
  end

  def update
    @task.update(task_params)
    redirect_to task_path(@task)
  end

  def destroy
    @task.destroy
    redirect_to project_tasks_path(@project)
  end

private
  def set_task
    @task = Task.find(params[:task_id])
  end

  def set_project
    @project = Project.find(params[:project_id])
  end

  def task_params
    params.require(:task).permit(:title, :description, :assigned_to, :created_at, :completed_at, :status, :project_id)
  end
end
