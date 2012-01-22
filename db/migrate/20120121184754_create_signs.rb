class CreateSigns < ActiveRecord::Migration
  def change
    create_table :signs do |t|
      t.string :borough_code
      t.string :status_order
      t.integer :sign_sequence
      t.integer :curb_distance
      t.string :arrow_cardinal
      t.string :description

      t.timestamps
    end
  end
end
