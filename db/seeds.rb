users = [
  {username: 'collin602', firstname: 'Collin', lastname: 'Coutinho', password: 'password', twitter_id: '226319377', postcode: 'S10 3AU', account_type_id: 1, location_id: 1},
  {username: 'jrawsthorne', firstname: 'Jake', lastname: 'Rawsthorne', email: 'jake@jakerawsthorne.co.uk', password: 'password', twitter_id: '298769407', postcode: 'S10 3AU', account_type_id: 1, location_id: 1},
  {username: 'piepiperchef', firstname: 'Pie', lastname: 'Piper', email: 'jakerawsthorne@pie-piper.me', password: 'password', twitter_id: '965615031185485824', postcode: 'S10 3AU', account_type_id: 1, location_id: 1},
  {username: 'admin', firstname: 'Admin', lastname: 'User', password: 'admin', account_type_id: 3},
  {username: 'user', firstname: 'Regular', lastname: 'User', password: 'user', account_type_id: 1},
  {username: 'order_handler', firstname: 'Order', lastname: 'Handler', password: 'order_handler', account_type_id: 2},
  {username: 'seth', firstname: 'Seth', lastname: 'Faulkner', password: 'asd', twitter_id: '965555302560075776', postcode: 'S3 7HD', account_type_id: 1, location_id: 1},
  {username: 'lucas', firstname: 'Lucas', lastname: 'Maybury', email: 'lmaybury1@sheffield.ac.uk', password: 'qwerty', twitter_id: '965555302560075776', house: 'Flat 10, Crescent Flats', street: 'Endcliffe Crescent', postcode: 'S10 3ED', account_type_id: 3, location_id: 2},
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
  {user_id: 2, special_condition_id: 1},
  {user_id: 8, special_condition_id: 3},
]

order_states = [
  {name: 'Preparing'},
  {name: 'Ready'},
  {name: 'Complete'},
]

items = [
  {name: 'Pork pie', item_type_id: 1, price: 10.0, special_condition_id: 1,path: 'pork.jpg'},
  {name: 'Lamb shank pie', item_type_id: 1, price: 10.0, special_condition_id: 1, path: 'lamb-shank.jpg'},
  {name: 'Mash', item_type_id: 2, price: 2.0,path:'mash.jpg'},
  {name: 'Gravy', item_type_id: 2, price: 2.0,path:'gravy.jpg'},
  {name: 'Coke', item_type_id: 3, price: 1.0,path:'coke.jpg'},
  {name: 'Strawberry milkshake', item_type_id: 4, price: 3.5,path:'strawberry.jpg'},
  {name: 'Cider', item_type_id: 5, price: 5.7,path:'cider.jpg'},
  {name: 'Sea bass puff pie', item_type_id: 1, price: 10.5, special_condition_id: 1,path:'sea-bass-puff.jpg'},
  {name: 'Lemon Meringue pie', item_type_id: 1, price: 10.0, special_condition_id: 2,path:'lemon-meringue.jpg'},
  {name: 'Kale, Chestnut and Mushroom pie', item_type_id: 1, price: 10.5, special_condition_id: 3,path:'kale-chestnut-mushroom.jpg'},
  {name: 'Venison & Bacon pie', item_type_id: 1, price: 10.0, special_condition_id: 1,path:'venison-bacon.jpg'},
  {name: 'Pineapple pie', item_type_id: 1, price: 10.5, special_condition_id: 3,path:'pineapple.jpg'},
  {name: 'Apple pie', item_type_id: 1, price: 10.5, special_condition_id: 3,path:'apple.jpg'},
  {name: 'Feta Spinach pie', item_type_id: 1, price: 10.5, special_condition_id: 3,path:'feta-spinach.jpg'},
  {name: 'Mushroom Asparagus pie', item_type_id: 1, price: 10.5, special_condition_id: 3,path:'mushroom-asparagus.jpg'},
  {name: 'Chicken & Leek pie', item_type_id: 1, price: 10.5, special_condition_id: 1,path:'chicken-leek.jpg'},
  {name: 'Coleslaw', item_type_id: 2, price: 2.0,path:'coleslaw.jpg'},
  {name: 'Chips/Fries', item_type_id: 2, price: 2.0,path:'fries.jpg'},
  {name: 'Mac n Cheese', item_type_id: 2, price: 2.0,path:'mac-n-cheese.jpg'},
  {name: 'Diet coke', item_type_id: 3, price: 1.0,path:'diet-coke.jpg'},
  {name: 'Fanta', item_type_id: 3, price: 1.0,path:'fanta.jpg'},
  {name: 'Vanilla milkshake', item_type_id: 4, price: 3.5,path:'vanilla.jpg'},
  {name: 'Chocolate milkshake', item_type_id: 4, price: 3.5,path:'chocolate.jpg'},
  {name: 'Lager', item_type_id: 5, price: 5.7,path:'lager.jpg'},
  {name: 'Special Lamb HotPot Pie', item_type_id: 1, price: 12, special_condition_id: 1, path:'lamb-hotpot.jpg'}
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

campaign_types = [
  {type_name: '10% Discount', percentage_reduced: 10},
  {type_name: '25% Discount', percentage_reduced: 25},
  {type_name: '50% Discount', percentage_reduced: 50},
  {type_name: 'Free item', percentage_reduced: 100},
  {type_name: '2-4-1'}
  ]

locations = [
  {name: "Sheffield"},
  {name: "Leeds"}
]

item_locations = [
  {item_id: 25, location_id: 2}
]

(1..24).each do |i|
    item_locations.push({item_id: i, location_id: 1})
    item_locations.push({item_id: i, location_id: 2})
  end

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

campaign_types.each do |u|
  CampaignType.create(u)
end

locations.each do |u|
  Location.create(u)
end

item_locations.each do |u|
  ItemLocation.create(u)
end
