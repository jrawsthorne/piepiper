users = [
  {username: 'collin602', firstname: 'Collin', lastname: 'Coutinho', password: 'password', twitter_id: '226319377', address: 'S10 3AU', account_type_id: 1},
  {username: 'jrawsthorne', firstname: 'Jake', lastname: 'Rawsthorne', password: 'password', twitter_id: '298769407', address: 'S10 3AU', account_type_id: 1},
  {username: 'piepiperchef', firstname: 'Pie', lastname: 'Piper', password: 'password', twitter_id: '965615031185485824', address: 'S10 3AU', account_type_id: 1},
  {username: 'admin', firstname: 'Admin', lastname: 'User', password: 'admin', account_type_id: 3},
  {username: 'user', firstname: 'Regular', lastname: 'User', password: 'user', account_type_id: 1},
  {username: 'order_handler', firstname: 'Order', lastname: 'Handler', password: 'order_handler', account_type_id: 2}
]

special_conditions = [
  {name: 'Non-vegetarian'},
  {name: 'Vegan'},
  {name: 'Vegetarian'},
  {name: 'Gluten free'},
  {name: 'Nut allergy'},
  {name: 'Dairy allergy'},
]

user_special_conditions = [
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

user_special_conditions.each do |u|
  UserSpecialCondition.create(u)
end
