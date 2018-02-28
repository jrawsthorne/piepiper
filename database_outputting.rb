require 'sqlite3'

db = SQLite3::Database.new "items.db"

items = db.execute "SELECT * FROM items WHERE item_type == 'Pie'"
for i in items
  for e in i
    print e.to_s + "|"
  end
  puts
end
