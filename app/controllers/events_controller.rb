class EventsController < ApplicationController
  def show
    @event = Event.find(params[:id])
  end

  def join
  	@event = Event.find(params[:id])
  	EventAttendence.create!(event_id: @event.id, user_id: current_user.id)
  	redirect_to event_path(@event)
  end

  def can_join
  	
  end

end