class TasksController < ApplicationController
  before_action :set_project
  before_action :set_task

  def index
    @tasks = @project.tasks
  end

  def new
    @task = project.tasks.build
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      @project = @task.project
      redirect_to task_path(@task)
    else
      render :new
    end
  end

  def show
    @project = @task.project
  end

  def edit
    @task = project.task.find(params[:id])
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
  def set_tasks
    @task = Task.find_by(id: params[:id])
  end

  def set_project
    @project = Project.find_by(id: params[:project_id])
  end

  def tasks_params(:task).permit(:title, :description, :assigned_to, :created_at, :completed_at, :status, :project_id)
  end
end
