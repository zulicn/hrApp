class Workshop < ActiveRecord::Base

  validates :name, presence: true
  validates :lc, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validate :start_date_before_end_date

  has_many :workshop_attendences
  has_many :users, through: :workshop_attendences
  has_one :report, foreign_key: "workshop_id", class_name: "WorkshopReport"

  def start_date_before_end_date
    if start_date > end_date
      errors.add(:datum, "Kraj radionice mora biti poslije početka")
  	end
  end

  def deadline
    start_date - 1.month
  end

  def self.for_apply
    where('start_date > ?', 1.month.from_now)
  end

  def self.deadline_expired
    where('start_date < ?', 1.month.from_now)
  end

  def recorded?
    workshop_attendences.any?
  end

  def no_member?
    workshop_attendences.where(no_member: true).any?
  end

end