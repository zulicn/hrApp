module Admin
  class EventAttendencesController < AdminController
  	respond_to :html

  	def charge_fee
  		event_attendence = EventAttendence.find(params[:event_attendence_id])
  		event_attendence.update_attribute(:is_charge_paid, true)
  		redirect_to admin_event_charges_logs_path(event_attendence.event)
  	end

  	def commit_attendence
  		event_attendence = EventAttendence.find(params[:event_attendence_id])
  		event_attendence.update_attribute(:is_attended, true)
  		redirect_to admin_event_attendence_logs_path(event_attendence.event)
  	end

  end
end