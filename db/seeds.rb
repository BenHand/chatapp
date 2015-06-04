5.times do ChatRoom.create(username:  Faker::Internet.user_name,
                                msg: Faker::Company.catch_phrase)
end
