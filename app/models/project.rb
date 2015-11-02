class Project < ActiveRecord::Base
  has_many :project_teams
  has_many :memberships
  has_many :teams, through: :project_teams
  has_many :users, through: :memberships

  def member?(user)
    users.include?(user)
  end
end