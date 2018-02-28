require 'sqlite3'

db = SQLite3::Database.open "items.db"

def get_item()
  puts "What is the item? "
  return gets
end

def get_item_type()
  puts "What type of item is it?"
  puts "Enter associated number:
  1. Pie
  2. Side
  3. Soft drinks
  4. Milkshakes
  5. Alcohol"

  type = gets
  if type == 1
    return "Pie"
  elsif type == 2
    return "Side"
  elsif type == 3
    return "Soft drinks"
  elsif type == 4
    return "Milkshakes"
  elsif type == 5
    return "Alcohol"
  end
end

def get_price()
  puts "What is the price"
  price = gets
  #should probably check the type
  return price
end

def get_special_condition()
  puts "What is the special condition"
  return gets
end

#item = get_item
#item_type = get_item_type
#price = get_price
#special_condition = get_special_condition

#db.execute "INSERT INTO items(item, item_type, price, special_condition) VALUES (?, ?, ?, ?, ?)", [item, item_type, price, special_condition]

items = db.execute "SELECT * FROM items ORDER BY item_type;"

items = db.execute "SELECT * FROM items WHERE item_type == 'Pie'"
for i in items
  for e in i
    print e.to_s + "|"
  end
  puts
end
