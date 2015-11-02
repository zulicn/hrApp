class AddNoTeam < ActiveRecord::Migration
  def change
    Team.create!(name: 'Neaktivan', shortcode: 'NOTEAM')
  end
end
