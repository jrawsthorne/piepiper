#Connects User and UserSpecialCondition
class UserSpecialCondition < ActiveRecord::Base
  belongs_to :user
  belongs_to :special_condition
end
