class Event < ActiveRecord::Base
	belongs_to :event_type

	has_many :event_attendences
    has_many :users, through: :event_attendences

    def joined?(user)
        users.include?(user)
    end
end