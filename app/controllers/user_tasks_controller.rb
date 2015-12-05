class UserTasksController < ApplicationController
  def create
    UserTask.create!(task_id: params[:task_id], user_id: current_user.id)
    redirect_to dashboard_path
  end

  def new
    @user_task = UserTask.new
  end

  def edit
    @user_task = UserTask.where( 'user_id = ? AND task_id = ?', @current_user.id, params[:id]).take
    @task = Task.find(params[:id])
  end

  def update
    @user_task = UserTask.where( 'user_id = ? AND task_id = ?', @current_user.id, params[:id]).take
    @user_task.update(task_params)
    @user_task.save!
    redirect_to dashboard_path
  end

  def destroy
    userTask = UserTask.where( 'user_id = ? AND task_id = ?', @current_user.id, params[:id]).take
    userTask.destroy!
    redirect_to dashboard_path
  end

  def task_params
    params.require(:user_task).permit(:user_id, :task_id, :admin_report, :user_report)
  end
end