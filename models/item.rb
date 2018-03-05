class Item
  attr_accessor :id, :name, :price, :type, :special
  def initialize(id = nil, name = nil)
    if (id == nil)
      @id = $db.get_first_value("SELECT ID FROM Items WHERE Name = CAST(? as TEXT)",[name])
      @name = name
    else
      @name = $db.get_first_value("SELECT Name FROM Items WHERE ID = CAST(? as INTEGER)",[id])
      @id = id
    end
    @price = $db.get_first_value("SELECT Price FROM Items WHERE ID = CAST(? as INTEGER)",[@id])
    @type = get_item_type(id: $db.get_first_value("SELECT ItemTypes.ID FROM ItemTypes INNER JOIN Items ON Items.Type = ItemTypes.ID WHERE Items.ID = CAST(? as INTEGER)",[@id]))
    @special = get_item_special(id: $db.get_first_value("SELECT SpecialCondition.ID FROM SpecialCondition INNER JOIN Items ON Items.Special = SpecialCondition.ID WHERE Items.ID = CAST(? as INTEGER)",[@id]))
  end
end

class ItemType
  attr_accessor :id, :name
  def initialize(id = nil, name = nil)
    if (id == nil)
      @id = $db.get_first_value("SELECT ID FROM ItemTypes WHERE Name = CAST(? as TEXT)",[name])
      @name = name
    else
      @name = $db.get_first_value("SELECT Name FROM ItemTypes WHERE ID = CAST(? as INTEGER)",[id])
      @id = id
    end
  end
end

class ItemSpecial
  attr_accessor :id, :name
  def initialize(id = nil, name = nil)
    if (id == nil)
      @id = $db.get_first_value("SELECT ID FROM SpecialCondition WHERE Name = CAST(? as TEXT)",[name])
      @name = name
    else
      @name = $db.get_first_value("SELECT Name FROM SpecialCondition WHERE ID = CAST(? as INTEGER)",[id])
      @id = id
    end
  end
end