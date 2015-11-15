class UserTasksController < ApplicationController
  def create
    UserTask.create!(task_id: params[:task_id], user_id: current_user.id)
    redirect_to dashboard_path
  end
end