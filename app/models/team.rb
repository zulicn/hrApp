class Team < ActiveRecord::Base
  def self.no_team
    @no_team ||= Team.find_by(shortcode: 'NOTEAM')
  end
end