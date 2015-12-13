class EventsController < ApplicationController

  def index
    @user_events = Event.joins(:event_attendences).where(event_attendences: { user_id: current_user.id })
  end

  def show
    @event = Event.find(params[:id])
  end

  def join
  	@event = Event.find(params[:id])
  	EventAttendence.create!(event_id: @event.id, user_id: current_user.id)
  	redirect_to event_path(@event)
  end

end