class CreateRoomUserTable < ActiveRecord::Migration
  def up
    create_table :room_users do |t|
      t.integer :room_id
      t.integer :user_id
    end
  end

  def down
    drop_table :room_users
  end
end
