class ItemType < ActiveRecord::Base
end

class SpecialCondition < ActiveRecord::Base
end

class Item < ActiveRecord::Base
  belongs_to :special_condition
  belongs_to :item_type
end