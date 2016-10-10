# class CreateDestinations < ActiveRecord::Migration[5.0]
#   def change
#     create_table :destinations do |t|
#       t.integer :distance
#       t.string :distance_text
#       t.integer :duration
#       t.string :duration_text
#       t.integer :origin_id
#       t.string :origin_type
#       t.string :origin_address
#       t.string :address
#       t.float :geo_coords, array: true, default: []
#
#       t.timestamps
#     end
#
#     add_index :destinations, [:origin_type, :origin_id]
#   end
# end
