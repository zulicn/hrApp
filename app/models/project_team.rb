class ProjectTeam < ActiveRecord::Base
  belongs_to :project
  belongs_to :team
  has_many :tasks
end