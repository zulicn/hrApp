class AddUserReportToUserTasks < ActiveRecord::Migration
  def change
    add_column :user_tasks, :user_report, :string
  end
end
