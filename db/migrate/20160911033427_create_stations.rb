class CreateStations < ActiveRecord::Migration[5.0]
  def change
    create_table :stations do |t|
      t.integer :divvy_id
      t.string :station_name
      t.integer :available_docks
      t.integer :total_docks
      t.decimal :latitude, precision: 8
      t.decimal :longitude, precision: 8
      t.string :status_value
      t.integer :status_key
      t.string :status
      t.integer :available_bikes
      t.string :st_address1
      t.string :st_address2
      t.string :city
      t.string :postal_code
      t.string :location
      t.string :altitude
      t.boolean :test_station
      t.datetime :last_communication_time
      t.string :land_mark
      t.boolean :is_renting


      t.timestamps
    end
  end
end
