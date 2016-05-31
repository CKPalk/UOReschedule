class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :coursecode
      t.string :coursename
      t.string :gsc
      t.string :credits
      t.string :tag
      t.integer :crn
      t.integer :avail_seats
      t.integer :max_seats
      t.string :time
      t.string :day
      t.string :location
      t.string :notes

      t.timestamps null: false
    end
  end
end
