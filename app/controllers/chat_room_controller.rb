class ChatRoomController < ApplicationController

  def index
    current_time = Time.now
    all_msg = ChatRoom.where(room: 'Global').order(:id)
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
      room = 'Global'
    end
    new_msg = ChatRoom.create(username: params[:username],
                                   msg: Swearjar.default.censor(params[:msg]),
                                  room: room), chat_bot(params[:msg], room)

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
    msgcount = []
    chatrooms = ChatRoom.all.group_by { |room| room.room }
                        .sort_by { |room| room.count }
                        .reverse
                        .take(3)
                        .map { |rooms| rooms.first }

    chatrooms.each do |room|
      msgcount << ChatRoom.where(room: room).count
      msgcount.sort!.reverse!
    end
    array_zip = chatrooms.zip(msgcount)
    render json: array_zip
  end

  def chat_bot(msg, room)
    bot_keywords =    { "amiright" => "you are so right!",
                               "?" => "42",
                              "??" => "its the answer",
                             "???" => "to the ultimate question",
                            "????" => "of Life, the Universe, and Everything.",
                        "shutdown" => "I'm sorry, #{params[:username].capitalize}. I'm afraid i can't do that.",
     "surely you can't be serious" => "I am serious... and don't call me Shirley" }

    if bot_keywords.keys.include?(msg)
      ChatRoom.create(username: 'Chat_Bot',
                           msg: bot_keywords[msg],
                          room: room)
    end
  end

  def date_range
    start_date = params[:start_date].to_datetime
    end_date = params[:end_date].to_datetime
    all_msg = ChatRoom.where(room: params[:room], created_at: start_date..end_date)

    render json: all_msg
  end

end
