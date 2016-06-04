class AddGroupSatisfyingToCourse < ActiveRecord::Migration
  def change
    add_reference :courses, :group_satisfying, index: true, foreign_key: true
  end
end
