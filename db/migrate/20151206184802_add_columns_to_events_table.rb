class AddColumnsToEventsTable < ActiveRecord::Migration
  def change
    add_column :event_attendences, :is_charge_paid, :boolean, :default => false
    add_column :event_attendences, :is_attended, :boolean, :default => false

    EventAttendence.all.each do |e|
    	e.update_attribute(:is_charge_paid, false)
    	e.update_attribute(:is_attended, false)
    end
  end
end
