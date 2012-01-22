class AddGeoDataToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :from_lat, :float
    add_column :locations, :from_lon, :float
    add_column :locations, :to_lat, :float
    add_column :locations, :to_lon, :float
    add_column :locations, :length, :float
  end
end
