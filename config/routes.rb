Rails.application.routes.draw do
  # TODO: "''/welcome" post to create new username
  get '/chat', to: 'chat_room#index' # getting all messages w/in last 4 hours
  get '/chat/profile/:username', to: 'chat_room#profile'

  # TODO: "''" post to create new username
  # post "''", to: 'chat_room#create'

  # TODO: post /chat to send new messages
  root to: 'chat_room#index'
end
""
