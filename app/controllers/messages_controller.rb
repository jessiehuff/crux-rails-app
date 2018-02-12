class MessagesController < ApplicationController
  before_action :set_message, only: [:edit, :update, :show, :destroy]
  before_action :set_project

  def index

  end

  def new
    @message = Message.new(project_id: @project.id)
  end

  def create
    @message = Message.new(message_params)
    if @message.save
      @project = @message.project
      reidrect_to project_messages_path(@project)
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
  def set_project
    if params[:id]
      @project = Project.find_by(id: params[:id])
    else
      @project = Project.find_by(id: params[:project_id])
    end
  end

  def set_message
    @message = Message.find_by(id: params[:id])
  end

  def message_params
    params.require(:message).permit(:title, :content, :created_at, :updated_at, :project_id, :user_id)
  end
end
