class ExtendWorkshopAttendences < ActiveRecord::Migration
  def change
  	change_column_null :workshop_attendences, :user_id, true
  	add_column :workshop_attendences, :no_member, :boolean, :default => false
  end
end
