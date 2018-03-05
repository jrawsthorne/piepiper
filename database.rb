require 'sqlite3'

db = SQLite3::Database.open "piepiper.db"

def query(db, table, attribute_searched, operator, value_wanted) #outputs as an array of arrays
  #parameters are: the databse variable, the table searched, column, operator
  #eg things(db, items, type, =, 1)
  sqlQuery = "SELECT * FROM " + table
  if attribute_searched != nil?
    sqlQuery += " WHERE " + attribute_searched + " " + operator + " " + value_wanted +";"
  end
  data = db.execute sqlQuery
  return data
end

def dataOutput(list)
  for i in list
    for e in i
      print e.to_s + "|"
    end
    puts
  end
end

#items = db.execute "SELECT * FROM items WHERE type=1;"
#these do the same thing, so you know how it all works
#print query(db, "items", "type", "=", "1")
#dataOutput(query(db, "items", "type", "=", "1"))
