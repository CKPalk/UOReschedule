class Course < ActiveRecord::Base
  has_one :datetime
  #has_one :department
  has_one :group_satisfying
  has_one :location
end
