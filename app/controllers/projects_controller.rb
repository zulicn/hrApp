class ProjectsController < ApplicationController

  def index
    @projects = Project.all.order(:start_date).reverse
  end

  def show
    @project = Project.find(params[:id])
    @tasks = @current_user.tasks.joins(:project_team).where('project_teams.project_id' => params[:id]).active
  end
end