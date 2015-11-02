module Admin
  class DashboardsController < AdminController
    def show
      @dashboard = Dashboard.new(current_user).build
    end
  end
end