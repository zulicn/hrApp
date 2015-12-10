module Admin
  class TeamsController < AdminController
    def index
      @teams = Team.all.order(:name)
    end

    def new
      @team = Team.new
    end

    def edit
      @team = Team.find(params[:id])
    end

    def show
      @team = Team.find(params[:id])
    end

    def create
      @team = Team.create(team_params)
      if @team.save
        redirect_to admin_teams_path
      else
        render 'new'
      end
    end

    def update
      @team = Team.find(params[:id])
      @team.update(team_params)
      if @team.save
        redirect_to admin_teams_path
      else
        render 'edit'
      end
    end

    def destroy
      team = Team.find(params[:id])
      team.destroy!
      redirect_to admin_teams_path
    end

    private

    def team_params
      params.require(:team).permit(:name, :shortcode)
    end
  end
end