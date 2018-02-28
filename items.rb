require "sqlite3"

db = SQLite3::Database.new "items.sql"


rows = db.execute <<-SQL
CREATE TABLE items (
  item VARCHAR NOT NULL(50),
  item_type VARCHAR(50),
  price VARCHAR(50),
  special_condition VARCHAR(50)
);

SQL
db.close
