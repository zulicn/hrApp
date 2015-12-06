class AddAcceptedToUserTask < ActiveRecord::Migration
  def change
  	add_column :user_tasks, :accepted, :boolean
  end
end
