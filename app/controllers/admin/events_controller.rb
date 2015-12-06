module Admin
  class EventsController < AdminController
  	respond_to :html
  	before_filter :check_submit, only: [:create, :update]

  	def index
      @events = Event.all
    end

    def new
      @event = Event.new
    end

    def edit
      @event = Event.find(params[:id])
    end

    def create
      event = Event.create(event_params)
      event.save!
      if params[:should_send_email]
        see_event_url = event_url(event)
        EestecMailer.new_event(event.id, see_event_url).deliver
      end
      redirect_to admin_events_path
    end

    def update
      event = Event.find(params[:id])
      event.update(event_params)
      event.save!
      redirect_to admin_events_path
    end

    def destroy
      event = Event.find(params[:id])
      event.destroy!
      redirect_to admin_events_path
    end

    def archive
      event = Event.find(params[:id])
      event.update!(is_active: false)
      redirect_to admin_events_path
    end

    def activate
      event = Event.find(params[:id])
      event.update!(is_active: true)
      redirect_to admin_events_path
    end

    def attendence_logs
      @event_attendences = Event.find(params[:event_id]).event_attendences
    end

    def charges_logs
      @event_charges = Event.find(params[:event_id]).event_attendences
    end


    def event_params
      params.require(:event).permit(:name, :description, :start_date, :end_date, :event_type_id, :is_chargeable, :should_record_attendence)
    end

    def check_submit
      return redirect_to admin_events_path if params[:cancel].present?
    end
  end
end