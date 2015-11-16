class Task < ActiveRecord::Base
  belongs_to :team
  belongs_to :project_team
  belongs_to :creator, class_name: 'User'

  has_many :user_tasks
end