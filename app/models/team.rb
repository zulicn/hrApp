class Team < ActiveRecord::Base

  validates :name, presence: true, uniqueness: true
  validates :shortcode, presence: true, uniqueness: true

  def self.no_team
    @no_team ||= Team.find_by(shortcode: 'NOTEAM')
  end
end