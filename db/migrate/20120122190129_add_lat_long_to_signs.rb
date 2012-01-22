class AddLatLongToSigns < ActiveRecord::Migration
  def change
    add_column :signs, :lat, :float
    add_column :signs, :lng, :float
  end
end
