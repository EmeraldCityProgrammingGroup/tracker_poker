class AddClosedToRoom < ActiveRecord::Migration
  def change
    add_column :rooms, :closed, :boolean, :default => false
  end
end
