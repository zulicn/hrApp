class Event < ActiveRecord::Base
	belongs_to :event_type

	has_many :event_attendences
    has_many :users, through: :event_attendences

    def should_record_attendence_msg
    	msg = "Ne"
        msg = "Da" if should_record_attendence
        msg
    end

    def is_chargeable_msg
    	msg = "Besplatan"
    	msg = "Naplata" if is_chargeable
    	msg
    end
end