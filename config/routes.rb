Rails.application.routes.draw do
  # TODO: "''/welcome" post to create new username
  get '/chat', to: 'chat_room#index' # getting all messages w/in last 4 hours
  get '/chat/history', to: 'chat_room#history'
  get '/chat/profile/:username', to: 'chat_room#profile'
  get '/leaderboard', to: 'chat_room#leaderboard'
  post '/new_user', to: 'chat_room#create_user'
  post '/chat', to: 'chat_room#post_msg'

  root to: 'chat_room#index'
end

