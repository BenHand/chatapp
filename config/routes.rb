Rails.application.routes.draw do

  # getting all messages w/in last 5 minutes
  get '/chat', to: 'chat_room#index'

  # getting all messages since creation
  get '/chat/history', to: 'chat_room#history'

  # getting all messages within a room from a start date to end date
  get '/chat/history/:room/:start_date/:end_date', to: 'chat_room#room_history'

  #getting all messages from a specific user
  get '/chat/profile/:username', to: 'chat_room#profile'

  # getting all messages within specified room within specified time window
  get '/chat/:room', to: 'chat_room#which_room'

  # getting top 10 users with message count
  get '/leaderboard', to: 'chat_room#leaderboard'

  # getting all users who have been active within last 4 hours
  get '/recent', to: 'chat_room#recent_users'

  # getting all users who have been active within specified time window
  get '/recent/user/:time', to: "chat_room#recent_users"

  # getting all messages within specified time window
  get '/recent/:time',  to: 'chat_room#index'

  # getting most active rooms
  get '/most_active_rooms', to: 'chat_room#most_active_rooms'

  # getting list of all rooms
  # get '/all_rooms', to: 'chat_room#all_rooms'

  # posting a new user with a specified room
  post '/new_user', to: 'chat_room#create_user'

  # posting a message to specified room
  post '/chat', to: 'chat_room#post_msg'

  root to: 'chat_room#index'
end

