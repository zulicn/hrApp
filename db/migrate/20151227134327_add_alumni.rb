class AddAlumni < ActiveRecord::Migration
  def change
    if Role.where(name: 'Alumni').empty?
      r = Role.new
      r.name = 'Alumni'
      r.save
    end

    add_column :users, :alumni_position, :string
  end
end
