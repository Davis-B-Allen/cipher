class AddHeadingToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :heading, :float
  end
end
