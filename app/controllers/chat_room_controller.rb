class ChatRoomController < ApplicationController
# Time.now.strftime("%H:%M %m-%d-%y")
  def index
    render json: ChatRoom.all
  end

  def profile
    user = ChatRoom.where(username: params[:username]).order(created_at: :desc)
    render json: user
  end

  def create
    ChatRoom.create(username: params[:username], msg: params[:msg])
  end

end
