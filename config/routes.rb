Rails.application.routes.draw do
  # TODO: "''/welcome" post to create new username
  get '/chat', to: 'chat_room#index' # getting all messages w/in last 4 hours
  get '/chat/history', to: 'chat_room#history'
  get '/chat/profile/:username', to: 'chat_room#profile'
  get '/chat/:room', to: 'chat_room#which_room'
  get '/leaderboard', to: 'chat_room#leaderboard'
  get '/recent', to: 'chat_room#recent_users'
  get '/most_active_rooms', to: 'chat_room#most_active_rooms'
  get '/all_rooms', to: 'chat_room#all_rooms'
  post '/new_user', to: 'chat_room#create_user'
  post '/chat', to: 'chat_room#post_msg'

  root to: 'chat_room#index'
end

