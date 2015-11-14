class AddTasksTable < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :name, :null => false
      t.text :description, :null => false
      t.integer :num_of_members
      t.date :deadline_to_apply
      t.date :deadline
      t.text :note
      t.text :report
      t.references :creator, :null => false
      t.references :project_team
      t.references :team
      t.boolean :is_active

      t.timestamps
    end

    create_table :user_tasks do |t|
      t.references :user
      t.references :task
      t.text :admin_report

      t.timestamps
    end
  end
end
