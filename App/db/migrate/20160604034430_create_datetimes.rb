class CreateDatetimes < ActiveRecord::Migration
  def change
    create_table :datetimes do |t|
      t.integer :course_id, :null => false
      t.time :start_time
      t.time :end_time
      t.boolean :monday, :null => false
      t.boolean :tuesday, :null => false
      t.boolean :wednesday, :null => false
      t.boolean :thursday, :null => false
      t.boolean :friday, :null => false
      t.boolean :saturday, :null => false
      t.boolean :sunday, :null => false

      t.timestamps null: false
    end
  end
end
