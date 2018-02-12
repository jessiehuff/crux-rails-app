class TasksController < ApplicationController

private
  def tasks_params(:task).permit(:title, :description, :assigned_to, :created_at, :completed_at, :status, :project_id)
  end
end
