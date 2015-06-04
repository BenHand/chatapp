class ChatRoomController < ApplicationController

  def index
    current_time = Time.now
    render json: ChatRoom.all
  end

  def profile
    user = ChatRoom.where(username: params[:username]).order(created_at: :desc)
    render json: user
  end

  def create_user
    new_user = ChatRoom.create(username: params[:username])
    render json: new_user.username
  end

  def post_msg
    new_msg = ChatRoom.create(username: params[:username], msg: params[:msg])
    render json: new_msg
  end

end
