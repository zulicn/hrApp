class DashboardsController < ApplicationController
  def show
    if current_user.is_admin?
      redirect_to admin_dashboard_path
    else
      @dashboard = Dashboard.new(current_user, tasks: params[:tasks], projects: params[:projects]).build
    end
  end
end