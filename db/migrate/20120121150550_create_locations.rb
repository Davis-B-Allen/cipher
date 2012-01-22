class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :borough_code
      t.string :status_order
      t.string :main_street
      t.string :from_street
      t.string :to_street
      t.string :cardinal_side

      t.timestamps
    end
  end
end
