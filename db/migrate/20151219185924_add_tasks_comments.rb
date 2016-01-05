class AddTasksComments < ActiveRecord::Migration
  def change
  create_table :tasks_comments do |t|
      t.references :user
      t.references :task
      t.text :admin_report
	  t.text :comment
	  
      t.timestamps
  end
end
end
