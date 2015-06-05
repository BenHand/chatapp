class ChatRoomController < ApplicationController

  def index
    current_time = Time.now
    all_msg = ChatRoom.all
    recent_msg = []

    all_msg.each do |item|
      if (current_time - item.created_at) <= 300000
        recent_msg << item
      end
    end
    render json: recent_msg
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

  def history
    render json: ChatRoom.all
  end

  def leaderboard
    # grouped_users = ChatRoom.group(:username).order(msg: :desc).count(:msg).limit(5)
    # render json: grouped_users
    chatroom = ChatRoom.all.group_by { |room| room.username }
                           .sort_by { |username, msg| msg.count }
                           .reverse
                           .take(10)
                           .map { |rooms| rooms.first }
    render json: chatroom
   end
end
