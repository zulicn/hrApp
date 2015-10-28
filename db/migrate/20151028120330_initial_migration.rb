class InitialMigration < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string :name, :null => false
    end

    create_table :departments do |t|
      t.string :name, :null => false
    end

    create_table :users do |t|
      t.references :role, :null => false
      t.string :firstname
      t.string :lastname
      t.string :username
      t.string :email
      t.string :phone
      t.references :department, :null=> false
      t.string :password_digest
      t.date :birth_date
      t.string :place_of_birth
      t.text :previous_experience
      t.text :reason_of_enrollment
      t.text :additional_skills
      t.boolean :is_accepted, :default => true

      t.timestamps
    end

    create_table :projects do |t|
      t.string :name, :null => false
      t.string :description, :null => false
      t.date :start_date
      t.date :end_date
      t.boolean :is_active, :default => true

      t.timestamps
    end

    create_table :events do |t|
      t.string :name
      t.string :description
      t.datetime :start_date
      t.datetime :end_date
      t.boolean :is_chargeable

      t.timestamps
    end
  end
end
