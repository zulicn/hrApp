module Admin
  class TasksController < AdminController
    def new
      @task = Task.new()
      @project_team = ProjectTeam.find(params[:project_team_id])
    end

    def create
      task = Task.create(task_params.merge(:creator_id => @current_user.id, :is_active => true, :project_team_id => params[:project_team_id]))
      task.save!
      redirect_to admin_project_path(params[:project_id])
    end

    private

    def task_params
      params.require(:task).permit(:name, :description, :num_of_members, :deadline_to_apply, :deadline, :note)
    end
  end
end