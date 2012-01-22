class AddDemoToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :demo, :boolean, :default => false, :null => false
  end
end
