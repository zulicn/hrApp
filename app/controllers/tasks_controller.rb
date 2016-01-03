class TasksController < ApplicationController

  def index
    @project = Project.find(params[:project_id])
    @current_user_task_ids = @current_user.tasks.pluck(:id) << -1
    @tasks = @project.tasks.open_for_apply.joins(:project_team).where('project_teams.team_id in (?) and tasks.id not in (?)', @current_user.memberships.where(:project_id => @project.id).pluck(:team_id), @current_user_task_ids)
  end

end