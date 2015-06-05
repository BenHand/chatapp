class ChatRoomController < ApplicationController

  def index
    current_time = Time.now
    all_msg = ChatRoom.all
    recent_msg = []

    all_msg.each do |item|
      if (current_time - item.created_at) <= 300
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
    if params[:room].present?
      room = params[:room]
    else
      room = 'global'
    end
    new_msg = ChatRoom.create(username: params[:username], msg: params[:msg], room: room)
    render json: new_msg
  end

  def history
    render json: ChatRoom.all
  end

  def leaderboard
    chatroom = ChatRoom.all.group_by { |room| room.username }
                           .sort_by { |username, msg| msg.count }
                           .reverse
                           .take(10)
                           .map { |rooms| rooms.first }
                           #.bopit
    render json: chatroom
  end

  def recent_users
    current_time = Time.now
    all_users = ChatRoom.all
    recent_users = []

    all_users.each do |item|
      if (current_time - item.created_at) <= 14400
        if recent_users.include?(item.username) == false
          recent_users << item.username
        end
      end
    end
    render json: recent_users
  end

  def most_active_rooms
    chatrooms = ChatRoom.all.group_by { |room| room.room }
                        .sort_by { |room| room.count }
                        .reverse
                        .take(5)
                        .map { |rooms| rooms.first }
    render json: chatrooms
  end

end
