class ExtendEvents < ActiveRecord::Migration
  def up
  	add_column :events, :is_active, :boolean, :default => true
    add_column :events, :should_record_attendence, :boolean, :default => false

  	create_table :event_types do |t|
      t.string :name, :null => false
      t.text :description
    end

    EventType.create!(name: 'Zabavni karakter', description: 'Nova godina, motivacijski vikend, party')
    EventType.create!(name: 'Ceremonija', description: 'Ceremonija otvaranja, zatvaranja')
    EventType.create!(name: 'Soft Skills Trening')
    EventType.create!(name: 'Radionica')
    EventType.create!(name: 'Sastanak')

    add_reference :events, :event_type
  end

  def down
  	EventType.destroy_all
  	remove_column :events, :is_active
    remove_column :events, :should_record_attendence
  	remove_reference :events, :event_type
  	drop_table :event_types
  end

end
