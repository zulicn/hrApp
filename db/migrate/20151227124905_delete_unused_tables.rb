class DeleteUnusedTables < ActiveRecord::Migration
  def change
  	drop_table :guests
  	drop_table :welcomes
  end
end
