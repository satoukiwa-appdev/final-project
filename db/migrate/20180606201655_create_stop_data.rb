class CreateStopData < ActiveRecord::Migration[5.1]
  def change
    create_table :stop_data do |t|
      t.string :station_name
      t.string :stop_name
      t.float :long
      t.float :lat
      t.integer :stop_id
      t.integer :map_id
      t.string :direction_idt
      t.float :abs_km
      t.integer :trdr

      t.timestamps
    end
  end
end
