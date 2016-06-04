class SetRefsToNotNull < ActiveRecord::Migration
  def change
    change_column_null :courses, :department_id, false
    change_column_null :courses, :datetime_id, false
    change_column_null :courses, :group_satisfying_id, false
    change_column_null :courses, :location_id, false
  end
end
