class Task < ActiveRecord::Base
  attr_accessor :admin_report
  belongs_to :team
  belongs_to :project_team
  belongs_to :project
  belongs_to :creator, class_name: 'User'

  has_many :user_tasks
  validates :name, presence: true
  validates :description, presence: true
  validates :num_of_members, presence: true
  validates :deadline_to_apply, presence: true
  validates :deadline, presence: true
  validate :start_date_before_end_date

  scope :active, -> { where(is_active: true) }

  def self.open_for_apply 
    where('is_active = ? and deadline_to_apply > ?', true, Time.now)
  end

  def late?
    Time.now > deadline
  end

  def deadline_to_apply_over?
    return deadline_to_apply < Time.now unless deadline_to_apply.nil?
    false
  end

  def start_date_before_end_date
    if deadline_to_apply > deadline
      errors.add(:datum, "Krajnji datum za prijave treba biti prije krajnjeg datuma za završetak zadatka")
  	end
  end

  def days_to_deadline
    (deadline - Date.today).to_i
  end
end