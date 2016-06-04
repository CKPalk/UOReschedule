class CreateGroupSatisfyings < ActiveRecord::Migration
  def change
    create_table :group_satisfyings do |t|
      t.integer :course_id, :null => false
      t.boolean :AL, :null => false
      t.boolean :SCC, :null => false
      t.boolean :SC, :null => false
      t.boolean :AC, :null => false
      t.boolean :IP, :null => false
      t.boolean :IC, :null => false

      t.timestamps null: false
    end
  end
end
