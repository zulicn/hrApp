class PopulateTeamTable < ActiveRecord::Migration
  def up
    Team.create!(name: 'Tim za namicanje sredstava', shortcode: 'FR')
    Team.create!(name: 'Tim za odnose s javnoscu', shortcode: 'PR')
    Team.create!(name: 'Tim za logistiku i ljudske resurse', shortcode: 'HR')
    Team.create!(name: 'Tim za informacione tehnologije', shortcode: 'IT')
    Team.create!(name: 'Tim za dizajn i publikacije', shortcode: 'DIZAJN')
    Team.create!(name: 'Grant tim', shortcode: 'GRANT')
  end

  def down
    Team.destroy_all
  end
end
