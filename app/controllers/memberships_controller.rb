class MembershipsController < ApplicationController
  def new
    @project = Project.find(params[:project_id])
  end

  def create
    params[:teams] ||= []
    params[:teams].each do |team|
      Membership.create!(project_id: params[:project_id], team_id: team, user_id: current_user.id)
    end
    redirect_to dashboard_path
  end

  def reject
    Membership.create!(project_id: params[:project_id], team_id: Team.no_team.id, user_id: current_user.id)
    redirect_to dashboard_path
  end
end