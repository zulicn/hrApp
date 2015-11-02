class AddProjectTeams < ActiveRecord::Migration
  def change
    create_table :project_teams do |t|
      t.references :project
      t.references :team
    end
  end
end
