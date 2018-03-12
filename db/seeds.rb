users = [
  {username: 'collin602', firstname: 'Collin', lastname: 'Coutinho', password: 'password', twitter_id: '226319377', special_condition_id: nil, address: 'S10 3AU', account_type_id: 1},
  {username: 'jrawsthorne', firstname: 'Jake', lastname: 'Rawsthorne', password: 'password', twitter_id: '298769407', special_condition_id: nil, address: 'S10 3AU', account_type_id: 2},
  {username: 'piepiperchef', firstname: 'Pie', lastname: 'Piper', password: 'password', twitter_id: '965615031185485824', special_condition_id: nil, address: 'S10 3AU', account_type_id: 3}
]

special_conditions = [
  {name: 'Non-vegetarian'},
  {name: 'Vegan'},
  {name: 'Vegetarian'},
  {name: 'Gluten free'},
  {name: 'Nut alergy'},
  {name: 'Dairy alergy'},
]

special_conditions_users = [
  {user_id: 1, special_condition_id: 3},
  {user_id: 1, special_condition_id: 5},
  {user_id: 2, special_condition_id: 1}
]

order_states = [
  {name: 'Preparing'},
  {name: 'Complete'},
]

items = [
  {name: 'Pork pie', item_type_id: 1, price: 10.0, special_condition_id: 1},
  {name: 'Lamb shank pie', item_type_id: 1, price: 10.0, special_condition_id: 1},
  {name: 'Mash', item_type_id: 2, price: 2.0},
  {name: 'Gravy', item_type_id: 2, price: 2.0},
  {name: 'Coke', item_type_id: 3, price: 1.0},
  {name: 'Strawberry milkshake', item_type_id: 4, price: 3.5},
  {name: 'Cider', item_type_id: 5, price: 5.7},
  {name: 'Sea bass puff pie', item_type_id: 1, price: 10.5, special_condition_id: 1},
  {name: 'Lemon Meringue pie', item_type_id: 1, price: 10.0, special_condition_id: 2},
  {name: 'Kale, Chestnut and Mushroom pie', item_type_id: 1, price: 10.5, special_condition_id: 3},
  {name: 'Venison & Bacon pie', item_type_id: 1, price: 10.0, special_condition_id: 1},
  {name: 'Pineapple pie', item_type_id: 1, price: 10.5, special_condition_id: 3},
  {name: 'Apple pie', item_type_id: 1, price: 10.5, special_condition_id: 3},
  {name: 'Feta Spinach pie', item_type_id: 1, price: 10.5, special_condition_id: 3},
  {name: 'Mushroom Asparagus pie', item_type_id: 1, price: 10.5, special_condition_id: 3},
  {name: 'Chicken & Leek pie', item_type_id: 1, price: 10.5, special_condition_id: 1},
  {name: 'Coleslaw', item_type_id: 2, price: 2.0},
  {name: 'Chips/Fries', item_type_id: 2, price: 2.0},
  {name: 'Mac n Cheese', item_type_id: 2, price: 2.0},
  {name: 'Diet coke', item_type_id: 3, price: 1.0},
  {name: 'Fanta', item_type_id: 3, price: 1.0},
  {name: 'Vanilla milkshake', item_type_id: 4, price: 3.5},
  {name: 'Chocolate milkshake', item_type_id: 4, price: 3.5},
  {name: 'Lager', item_type_id: 5, price: 5.7}
]

item_types = [
  {name: 'Pies'},
  {name: 'Sides'},
  {name: 'Soft drinks'},
  {name: 'Milkshakes'},
  {name: 'Alcohol'}
]

account_types = [
  {name: 'User'},
  {name: 'Order handler'},
  {name: 'Admin'}
]

users.each do |u|
  User.create(u)
end

special_conditions.each do |u|
  SpecialCondition.create(u)
end

order_states.each do |u|
  OrderState.create(u)
end

items.each do |u|
  Item.create(u)
end

item_types.each do |u|
  ItemType.create(u)
end

account_types.each do |u|
  AccountType.create(u)
end
