class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.integer :crn, :null => false
      t.string :course_name, :null => false
      t.integer :course_num, :null => false
      t.string :type_tag
      t.integer :max_credits, :null => false
      t.integer :min_credits
      t.string :instructor
      t.string :notes

      t.timestamps null: false
    end
  end
end
