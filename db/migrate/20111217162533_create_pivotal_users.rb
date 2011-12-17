class CreatePivotalUsers < ActiveRecord::Migration
  def change
    create_table :pivotal_users do |t|
      t.integer :user_id
      t.string :token

      t.timestamps
    end
  end
end
