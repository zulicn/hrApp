module Admin
  class WorkshopsController < AdminController
    def show
      @workshop = Workshop.find(params[:id])
    end

    def index
      @workshops = Workshop.all.order(:start_date).reverse
    end

    def new
      @workshop = Workshop.new
    end

    def create
      params[:teams] ||= []
      @workshop = Workshop.create(workshops_params)
      if @workshop.save
        redirect_to admin_workshops_path
      else
        render 'new'
      end
    end

    def edit
      @workshop = Workshop.find(params[:id])
    end

    def update
      @workshop = Workshop.find(params[:id])
      @workshop.update(workshops_params)
      if @workshop.save
        redirect_to admin_workshops_path
      else 
        render 'edit'
      end
    end

    def destroy
      workshop = Workshop.find(params[:id])
      workshop.destroy!
      redirect_to admin_workshops_path
    end

    private

    def workshops_params
      params.require(:workshop).permit(:name, :description, :lc, :start_date, :end_date)
    end
  end
end