class AddMaterialToTask < ActiveRecord::Migration
  def change
  	add_column :tasks, :material, :string
  end
end
