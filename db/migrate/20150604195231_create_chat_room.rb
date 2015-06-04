class CreateChatRoom < ActiveRecord::Migration
  def change
    create_table :chat_rooms do |t|
      t.string :username, null: false, default: 'anonymous'
      t.string :msg, default: ''
      t.string :room, default: 'global'

      t.timestamps null: false
    end
  end
end
