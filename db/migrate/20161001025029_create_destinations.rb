class CreateDestinations < ActiveRecord::Migration[5.0]
  def change
    create_table :destinations do |t|
      t.integer :distance
      t.string :distance_text
      t.integer :duration
      t.string :duration_text
      t.integer :origin_id
      t.string :origin_type

      t.timestamps
    end

    add_index :destinations, [:origin_type, :origin_id]
  end
end
