Rails.application.routes.draw do
  # TODO: "''/welcome" post to create new username
  get '/chat', to: 'chat_room#index' # getting all messages w/in last 4 hours
  get '/chat/profile/:username', to: 'chat_room#profile'

  post '/new_user', to: 'chat_room#create_user'
  post '/chat', to: 'chat_room#post_msg'

  root to: 'chat_room#index'
end

