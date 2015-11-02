class ProjectTeam < ActiveRecord::Base
  belongs_to :project
  belongs_to :team
end