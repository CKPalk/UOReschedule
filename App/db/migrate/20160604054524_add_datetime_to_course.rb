class AddDatetimeToCourse < ActiveRecord::Migration
  def change
    add_reference :courses, :datetime, index: true, foreign_key: true
  end
end
