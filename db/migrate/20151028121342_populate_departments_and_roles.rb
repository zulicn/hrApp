class PopulateDepartmentsAndRoles < ActiveRecord::Migration
  def up
    Role.create!(name: 'Member')
    Role.create!(name: 'Admin')
    Department.create!(name: 'Racunarstvo i informatika')
    Department.create!(name: 'Telekomunikacije')
    Department.create!(name: 'Automatika i elektronika')
    Department.create!(name: 'Energetika')
  end

  def down
    Role.destroy_all
    Department.destroy_all
  end
end
