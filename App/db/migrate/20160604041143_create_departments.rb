class CreateDepartments < ActiveRecord::Migration
  def change
    create_table :departments do |t|
      t.integer :course_id, :null => false
      t.string :code, :null => false
      t.string :full_name, :null => false

      t.timestamps null: false
    end
  end
end
