class CreateStoryVotes < ActiveRecord::Migration
  def change
    create_table :story_votes do |t|
      t.integer :story_id
      t.integer :user_id
      t.integer :room_id
      t.string :score

      t.timestamps
    end
  end
end
