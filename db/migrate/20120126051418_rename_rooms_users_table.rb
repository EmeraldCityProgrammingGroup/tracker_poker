class RenameRoomsUsersTable < ActiveRecord::Migration
  def change
    rename_table :room_users, :rooms_users
  end

end
