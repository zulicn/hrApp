module Admin
  class ProjectsController < AdminController
    before_filter :check_submit, only: [:create, :update]

    def index
      @projects = Project.all.order(:start_date).reverse
    end

    def new
      @project = Project.new
      @teams = Team.where.not(shortcode: 'NOTEAM')
    end

    def edit
      @project = Project.find(params[:id])
      @teams = Team.where.not(shortcode: 'NOTEAM')
    end

    def create
      params[:teams] ||= []
      project = Project.create(project_params)
      project.teams = Team.where(id: params[:teams])
      project.save!
      redirect_to admin_projects_path
    end

    def update
      params[:teams] ||= []
      project = Project.find(params[:id])
      project.update(project_params)
      project.teams = Team.where(id: params[:teams])
      project.save!
      redirect_to admin_projects_path
    end

    def archive
      project = Project.find(params[:id])
      project.update!(is_active: false)
      redirect_to admin_projects_path
    end

    def activate
      project = Project.find(params[:id])
      project.update!(is_active: true)
      redirect_to admin_projects_path
    end

    def destroy
      project = Project.find(params[:id])
      project.destroy!
      redirect_to admin_projects_path
    end

    private

    def project_params
      params.require(:project).permit(:name, :description, :start_date, :end_date)
    end

    def check_submit
      return redirect_to admin_projects_path if params[:cancel].present?
    end
  end
end