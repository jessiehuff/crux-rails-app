class MessagesController < ApplicationController
  before_action :set_project
  before_action :set_message, only: [:edit, :update, :show, :destroy]

  def index
    @messages = @project.messages.reverse
  end

  def new
    @message = Message.new
  end

  def create
    @message = Message.new(message_params)
    project_id = params["project_id"]
    @message.project_id = project_id
    if @message.save
      @project = @message.project
      redirect_to project_messages_path(@message)
    else
      render :new
    end
  end

  def show
    @project = @message.project
  end

  def edit
  end

  def update
    @message.update(message_params)
    flash[:notice] = "Message updated!"
    redirect_to project_messages_path(@message)
  end

  def destroy
    @project = @message.project
    @message.destroy
    redirect_to project_messages_path(@project)
  end

private
  def set_project
    @project = Project.find_by(params[:id])
  end

  def set_message
    @message = Message.find_by(params[:message_id])
  end

  def message_params
    params.require(:message).permit(:title, :content)
  end
end
