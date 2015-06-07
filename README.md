# Chat API
  This is a functioning chat server i created for a group project where the front end
  developer creates a website that uses my db for sending/storing/receiving messages.

## Do the following to use this program

* Fork this repo.
* Clone this repo.
* `bundle install` to install all gems required.
* `rake db:migrate` to run the migration and update the database.
* `rake db:seed` to populate your db with 5 randomly generated messages(via <a href="https://rubygems.org/gems/faker/versions/1.4.3">faker</a>).
* `rails s` to start your local server.

## Server URL and routes listed below with server responses.

Server url - https://localhost:3000

GET /chat - returns all messages from 'Global' chatroom within the last 5 minutes by default
SERVER RESPONSE = {
id: 366,
username: "5",
msg: "has entered the chatroom",
room: "Global",
created_at: "2015-06-07T17:27:24.426Z",
updated_at: "2015-06-07T17:27:24.426Z" }


GET /chat/history - returns all messages from all chatrooms from newest -> oldest
SERVER RESPONSE = same as /chat but in reverse order

GET /chat/profile/:username - returns all messages from specified user passed as :username
 parameter from all chatrooms ordered newest -> oldest
SERVER RESPONSE = same as /chat but only with specified usernames being sent

GET /chat/:room - returns all messages from specified chatroom using :room parameter within
 the last 5 minutes
SERVER RESPONSE = same as /chat but only with specified chatroom messages being
displayed

GET /leaderboard - returns the top 10 users with their total message count from most active
to least active
SERVER RESPONSE = [ [ "username" :  msg count  ] ] array of each user with their total msg
count where user with most messages returned first.

GET /recent - returns all users active within the last 4 hours
SERVER RESPONSE = [ "username", "username" ] a comma separated array of string
usernames that have made posts within the last 4 hours.

GET /recent/user/:time - returns all users active within the specified time window using :time
parameter
SERVER RESPONSE = same as /recent but returns all users active within the specified time
window

GET /recent/:time - returns all messages within specified time window using :time parameter
SERVER RESPONSE = same as /chat but only those within the specified time window

GET /most_active_rooms - returns the top 3 chat rooms
SERVER RESPONSE = [ [ "room", msg.count ] [ "room", msg.count ] [ "room", msg.count] ] a
comma separated array of string room names and integer msg.count from most active to
least active.

POST /new_user - creates a new user with :username and :room parameters and displays
message :username - has entered the chatroom.
SERVER RESPONSE = same as /chat but with a msg = "has entered the room"

POST /chat - creates a new message with :msg and :room parameters and checks message
for curse words and bot keys and provides appropriate response if necessary.
SERVER RESPONSE = same as /chat but with room and msg set to the params being sent
from java



-------
Math_Bot - when given a message starting with +: , -: , *: , /: followed by a space and two
comma separated numbers, math_bot will do the calculation and return the appropriate value.

Chat_Bot - when given a message with one of the following keys: amiright, ?, ??, ???, ????,
shutdown, surely you can't be serious; chat_bot will respond appropriately.

<a href="https://rubygems.org/gems/swearjar">Swearjar</a> - ruby gem prevents cursing within chat room.

-------
<a href="https://trello.com/b/ub26Hs6E/group-chat-program">Trello, Scrum Board</a>

```
▶ tree
.
├── Gemfile
├── Gemfile.lock
├── Procfile
├── README.md
├── README.rdoc
├── Rakefile
├── app
│   ├── assets
│   │   ├── images
│   │   ├── javascripts
│   │   │   ├── application.js
│   │   │   └── chat_room.coffee
│   │   └── stylesheets
│   │       ├── application.css
│   │       └── chat_room.scss
│   ├── controllers
│   │   ├── application_controller.rb
│   │   ├── chat_room_controller.rb
│   │   └── concerns
│   ├── helpers
│   │   ├── application_helper.rb
│   │   └── chat_room_helper.rb
│   ├── mailers
│   ├── models
│   │   ├── chat_room.rb
│   │   └── concerns
│   └── views
│       ├── chat_room
│       └── layouts
│           └── application.html.erb
├── bin
│   ├── bundle
│   ├── rails
│   ├── rake
│   ├── setup
│   └── spring
├── config
│   ├── application.rb
│   ├── boot.rb
│   ├── database.yml
│   ├── environment.rb
│   ├── environments
│   │   ├── development.rb
│   │   ├── production.rb
│   │   └── test.rb
│   ├── initializers
│   │   ├── assets.rb
│   │   ├── backtrace_silencers.rb
│   │   ├── cookies_serializer.rb
│   │   ├── filter_parameter_logging.rb
│   │   ├── inflections.rb
│   │   ├── mime_types.rb
│   │   ├── session_store.rb
│   │   └── wrap_parameters.rb
│   ├── locales
│   │   └── en.yml
│   ├── routes.rb
│   └── secrets.yml
├── config.ru
├── db
│   ├── development.sqlite3
│   ├── migrate
│   │   └── 20150604221354_create_chat_room.rb
│   ├── schema.rb
│   └── seeds.rb
├── lib
│   ├── assets
│   └── tasks
├── log
│   └── development.log
├── public
│   ├── 404.html
│   ├── 422.html
│   ├── 500.html
│   ├── favicon.ico
│   └── robots.txt
├── test
│   ├── controllers
│   │   └── chat_room_controller_test.rb
│   ├── fixtures
│   │   └── chat_rooms.yml
│   ├── helpers
│   ├── integration
│   ├── mailers
│   ├── models
│   │   └── chat_room_test.rb
│   └── test_helper.rb
├── tmp
│   ├── cache
│   │   └── assets
│   ├── pids
│   ├── sessions
│   └── sockets
└── vendor
    └── assets
        ├── javascripts
        └── stylesheets

43 directories, 54 files
```
