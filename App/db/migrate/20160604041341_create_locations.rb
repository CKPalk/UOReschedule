class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.integer :course_id, :null => false
      t.boolean :online, :null => false
      t.integer :seats_available, :null => false
      t.integer :seats_max, :null => false
      t.string :building
      t.string :room

      t.timestamps null: false
    end
  end
end
