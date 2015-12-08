class Task < ActiveRecord::Base
	   attr_accessor :admin_report
  belongs_to :team
  belongs_to :project_team
  belongs_to :creator, class_name: 'User'

  has_many :user_tasks
  validate :start_date_before_end_date

  def late?
    Time.now > deadline
  end

  def start_date_before_end_date
    if deadline_to_apply > deadline
      errors.add(:deadline_to_apply, "Krajnji datum za prijave treba biti prije krajnjeg datuma za završetak zadatka")
  	end
  end
end