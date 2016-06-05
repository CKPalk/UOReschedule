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
    end


    create_table :datetimes do |t|
      t.belongs_to :course, index: true
      t.time :start_time
      t.time :end_time
      t.boolean :monday, :null => false
      t.boolean :tuesday, :null => false
      t.boolean :wednesday, :null => false
      t.boolean :thursday, :null => false
      t.boolean :friday, :null => false
      t.boolean :saturday, :null => false
      t.boolean :sunday, :null => false
    end

    create_table :departments do |t|
      t.belongs_to :course, index: true
      t.string :code, :null => false
      t.string :full_name, :null => false
    end

    create_table :group_satisfyings do |t|
      t.belongs_to :course, index: true
      t.boolean :AL, :null => false
      t.boolean :SCC, :null => false
      t.boolean :SC, :null => false
      t.boolean :AC, :null => false
      t.boolean :IP, :null => false
      t.boolean :IC, :null => false
    end

    create_table :locations do |t|
      t.belongs_to :course, index: true
      t.boolean :online, :null => false
      t.integer :seats_available, :null => false
      t.integer :seats_max, :null => false
      t.string :building
      t.string :room
    end

  end
end
