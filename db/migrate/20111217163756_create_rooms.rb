class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.integer :project_id
      t.integer :current_story_id

      t.timestamps
    end
  end
end
