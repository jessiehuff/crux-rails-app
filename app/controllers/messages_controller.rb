class MessagesController < ApplicationController
  before_action :set_project
  before_action :set_message, only: [:edit, :update, :show, :destroy]

  def index
    @messages = @project.messages.reverse
    respond_to do |format| 
      format.html {render :index}
      format.json {render json: @messages}
    end 
  end

  def new
    @message = Message.new
    render layout: false
  end

  def create
    @message = Message.new(message_params)
    project_id = params["project_id"]
    @message.project_id = project_id
    if @message.save
      @project = @message.project
      render json: @message, status: 201
    else
      flash[:message] = @message.errors.full_messages
      render json: {errors: @message.errors.full_messages}, status: 400
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
  end

  def update
    @message.update(message_params)
    flash[:notice] = "Message updated!"
    redirect_to project_messages_path
  end

  def destroy
    @message.destroy
    redirect_to project_messages_path(@project)
  end

private
  def set_project
    @project = Project.find(params[:project_id])
  end

  def set_message
    @message = Message.find(params[:id])
  end

  def message_params
    params.require(:message).permit(:title, :content)
  end
end
