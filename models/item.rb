class ItemType < ActiveRecord::Base
end

class SpecialCondition < ActiveRecord::Base
  has_many :users, through: :special_conditions_users
  has_many :special_conditions_users
end

class Item < ActiveRecord::Base
  belongs_to :special_condition
  belongs_to :item_type
end
