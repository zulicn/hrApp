class EnableWorkshopReports < ActiveRecord::Migration
  def change
  	create_table :workshop_attendences do |t|
      t.references :user, :null=> false
      t.references :workshop, :null=> false

      t.timestamps
    end

    create_table :workshop_reports do |t|
      t.references :workshop, :null=> false
      t.text :content
      t.timestamps
    end

    create_table :workshop_report_images do |t|
      t.references :workshop_report, :null=> false
      t.string :image_url
      t.timestamps
    end

  end
end
