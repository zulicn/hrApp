class Workshop < ActiveRecord::Base

  validates :name, presence: true
  validates :lc, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validate :start_date_before_end_date

  def start_date_before_end_date
    if start_date > end_date
      errors.add(:datum, "Kraj radionice mora biti poslije početka")
  	end
  end

end