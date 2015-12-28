module Admin
  class WorkshopAttendencesController < AdminController
    def new
      @workshop = Workshop.find(params[:workshop_id])
    end

    def create
      params[:users] ||= []
      params[:users].each do |user|
        WorkshopAttendence.create!(workshop_id: params[:workshop_id], user_id: user)
      end
      redirect_to dashboard_path
    end

    def set_no_member
      workshop = Workshop.find(params[:workshop_id])
      WorkshopAttendence.create!(workshop_id: workshop.id, no_member: true)
      redirect_to admin_dashboard_path
    end

  end
end