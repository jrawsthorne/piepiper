class SpecialConditionsUsers < ActiveRecord::Base
  belongs_to :user
  belongs_to :special_condition
end
