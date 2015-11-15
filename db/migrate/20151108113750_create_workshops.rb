class CreateWorkshops < ActiveRecord::Migration
  def change
    create_table :workshops do |t|
      t.string :name
      t.string :description
      t.string :lc
      t.datetime :start_date
      t.datetime :end_date
    end
  end
end
