class Event < ActiveRecord::Base
	belongs_to :event_type

	has_many :event_attendences
    has_many :users, through: :event_attendences

    validates :name, presence: true
    validates :start_date, presence: true
    validates :end_date, presence: true
    validate :start_date_before_end_date

    def joined?(user)
        users.include?(user)
    end

    def start_date_before_end_date
    if start_date > end_date
      errors.add(:datum, "Kraj eventa mora biti poslije početka")
  	end
  end
end