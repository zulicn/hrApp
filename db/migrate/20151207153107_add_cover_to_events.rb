class AddCoverToEvents < ActiveRecord::Migration
  def change
  	add_column :events, :cover_url, :string
  end
end
