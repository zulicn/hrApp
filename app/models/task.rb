class Task < ActiveRecord::Base
	   attr_accessor :admin_report
  belongs_to :team
  belongs_to :project_team
  belongs_to :creator, class_name: 'User'

  has_many :user_tasks

  def late?
    Time.now > deadline
  end
end