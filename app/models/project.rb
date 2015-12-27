class Project < ActiveRecord::Base
  has_many :project_teams
  has_many :memberships
  has_many :teams, through: :project_teams
  has_many :users, through: :memberships
  has_many :tasks, through: :project_teams

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
  validate :start_date_before_end_date

  def member?(user)
    users.include?(user)
  end

  def start_date_before_end_date
    if start_date > end_date
      errors.add(:datum, "kraj projekta mora biti poslije početka projekta")
  	end
  end

end