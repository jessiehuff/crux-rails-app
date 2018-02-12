class TasksController < ApplicationController
  before_action :set_task

  def index
    @tasks = @project.tasks
  end

  def new
    @task = Task.new(project_id: @project.id)
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to task_path(@task)
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

private
  def set_tasks
    @task = Task.find_by(id: params[:id])
  end

  def tasks_params(:task).permit(:title, :description, :assigned_to, :created_at, :completed_at, :status, :project_id)
  end
end
