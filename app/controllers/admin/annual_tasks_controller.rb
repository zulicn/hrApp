module Admin
  class AnnualTasksController < AdminController
    def new
      @annual_task = Task.new()
      @team = Team.find(params[:team_id])
    end

    def create
      annual_task = Task.create(annual_task_params.merge(:creator_id => @current_user.id, :is_active => true, :team_id => params[:team_id]))
      annual_task.save!
      redirect_to admin_teams_path
    end

    private

    def annual_task_params
      params.require(:task).permit(:name, :description, :num_of_members, :deadline_to_apply, :deadline, :note)
    end
  end
end