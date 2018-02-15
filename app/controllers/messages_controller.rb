class MessagesController < ApplicationController
  before_action :set_project
  before_action :set_message, only: [:edit, :update, :show, :destroy]

  def index
    @messages = @project.messages.reverse
    respond_to do |format|
      format.hmtl {render :index}
      format.json {render: @messages}
    end
  end

  def new
    @message = project.messages.build
  end

  def create
    @message = Message.new(message_params)
    if @message.save
      @project = @message.project
      redirect_to project_messages_path(@project)
    else
      render :new
    end
  end

  def show
    @project = @message.project
    respond_to do |format|
      format.html {render :show}
      format.json {render json: @message}
    end
  end

  def edit
    @message = project.messages.find(params[:id])
  end

  def update
    @message.update(message_params)
  end

  def destroy
    @project = @message.project
    @message.destroy
    redirect_to project_messages_path(@project)
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
