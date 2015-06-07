class ChatRoomController < ApplicationController

  def index
    current_time = Time.now
    all_msg = ChatRoom.where(room: 'global').order(:id)
    recent_msg = []

    if params[:time].present?
      time_window = params[:time]
    else
      time_window = 300
    end

    all_msg.each do |item|
      if (current_time - item.created_at) <= time_window.to_i
        recent_msg << item
      end
    end
    render json: recent_msg
  end

  def which_room
    recent_msg = []
    current_time = Time.now

    if params[:room].present?
      all_msg = ChatRoom.where(room: params[:room]).order(:id)
    else
      all_msg = ChatRoom.where(room: 'Global').order(:id)
    end

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
    new_user = ChatRoom.create(username: params[:username], room: params[:room])
    render json: new_user.username
  end

  def post_msg
    if params[:room].present?
      room = params[:room]
    else
      room = 'global'
    end
    new_msg = ChatRoom.create(username: params[:username],
                                   msg: Swearjar.default.censor(params[:msg]),
                                  room: room)
    render json: new_msg
  end

  def history
    render json: ChatRoom.all.order(:id).reverse
  end

  def leaderboard
    chatroom = []
    msgcount = []
    users = ChatRoom.all.group_by { |room| room.username }
                           .sort_by { |username, msg| msg.count }
                           .reverse
                           .take(10)
                           .map { |rooms| rooms.first }
                           #.bopit
    users.each do |name|
      msgcount << ChatRoom.where(username: name).count
    end
    array_zip = users.zip(msgcount)
    render json: array_zip
  end

  def recent_users
    current_time = Time.now
    all_users = ChatRoom.all
    recent_users = []

    if params[:time].present?
      time_window = params[:time]
    else
      time_window = 14400
    end

    all_users.each do |item|
      if (current_time - item.created_at) <= time_window.to_i
        if recent_users.include?(item.username) == false
          recent_users << item.username
        end
      end
    end
    render json: recent_users
  end

  # def all_rooms
  #   chatrooms = ChatRoom.all.group_by { |room| room.room }
  #                       .sort_by { |room| room.count }
  #                       .map { |rooms| rooms.first }
  #   render json: chatrooms
  # end

  def most_active_rooms
    chatrooms = ChatRoom.all.group_by { |room| room.room }
                        .sort_by { |room| room.count }
                        .reverse
                        .take(3)
                        .map { |rooms| rooms.first }
    render json: chatrooms
  end

end
