class AddTeamAndMembershipTables < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :name, :null => false
      t.string :shortcode, :null => false

      t.timestamps
    end

    create_table :memberships do |t|
      t.references :team
      t.references :user, :null=> false
      t.references :project

      t.timestamps
    end
  end
end
