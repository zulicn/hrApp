module Admin
  class DashboardsController < AdminController
    def show
      @dashboard = Dashboard.new(current_user, tasks: params[:tasks], projects: params[:projects]).build
    end
  end
end