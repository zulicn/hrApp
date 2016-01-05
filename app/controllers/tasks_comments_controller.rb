class TasksCommentsController < ApplicationController

def create
	@user_task=UserTask.find(params[:user_task_id])
	TasksComment.create(task_comment_params.merge(:user_id => @current_user.id, :task_id => @user_task.task.id))
	
	redirect_to edit_user_task_path(@user_task)

end

def index
	@user_task=UserTask.find(params[:user_task_id])
  	@tasks_comments = TasksComment.all
end

def update
    @user_task = UserTask.where( 'id = ?',  @user_task.id).take
    @user_task.save!
    redirect_to dashboard_path
  end

def show
	@user_task=UserTask.find(params[:user_task_id])
  	@tasks_comments = TasksComment.all
end

def new
	@user_task=UserTask.find(params[:user_task_id])

	@tasks_comment = TasksComment.new()
end

def task_comment_params
    params.require(:tasks_comment).permit(:comment)
 end
end  