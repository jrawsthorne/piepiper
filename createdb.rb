require 'sqlite3'

begin
  File.delete('piepiper.db')

  rescue SystemCallError
    print "File not found, creating now..."
end

db = SQLite3::Database.new "piepiper.db"

db.execute_batch <<-SQL
  CREATE TABLE `Users` (
  `ID`	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,
  `Username`	TEXT NOT NULL UNIQUE,
  `Password`	TEXT NOT NULL,
  `TwitterID`	TEXT NOT NULL UNIQUE,
  `DietryRequirements`	TEXT,
  `Address`	TEXT NOT NULL,
  `AccountType`	INTEGER NOT NULL,
  FOREIGN KEY(`AccountType`) REFERENCES `AccountTypes`(`ID`)
  );
  CREATE TABLE `SpecialCondition` (
  `ID`	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,
  `Name`	TEXT NOT NULL UNIQUE
  );
  INSERT INTO `SpecialCondition` VALUES (1,'Non-vegetarian'),
  (2,'Vegan'),
  (3,'Vegetarian'),
  (4,'Gluten free');
  CREATE TABLE `Orders` (
  `ID`	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,
  `User`	INTEGER NOT NULL,
  `Tweet`	TEXT NOT NULL,
  `State`	INTEGER NOT NULL,
  FOREIGN KEY(`State`) REFERENCES `OrderStates`(`ID`),
  FOREIGN KEY(`User`) REFERENCES `Users`(`ID`)
  );
  CREATE TABLE `OrderStates` (
  `ID`	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,
  `Name`	TEXT
  );
  INSERT INTO `OrderStates` VALUES (1,'Preparing'),
  (2,'Complete');
  CREATE TABLE `OrderItems` (
  `ID`	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,
  `Order`	INTEGER NOT NULL,
  `Item`	INTEGER NOT NULL,
  `Quantity`	INTEGER NOT NULL DEFAULT 1,
  FOREIGN KEY(`Order`) REFERENCES `Orders`(`ID`),
  FOREIGN KEY(`Item`) REFERENCES `Items`(`ID`)
  );
  CREATE TABLE `Items` (
  `ID`	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,
  `Name`	TEXT NOT NULL UNIQUE,
  `Type`	INTEGER NOT NULL,
  `Price`	FLOAT,
  `Special`	INTEGER,
  FOREIGN KEY(`Special`) REFERENCES `SpecialCondition`(`ID`),
  FOREIGN KEY(`Type`) REFERENCES `ItemTypes`(`ID`)
  );
  INSERT INTO `Items` VALUES (1,'Pork pie',1,10.0,1),
  (2,'Lamb shank pie',1,10.0,1),
  (3,'Mash',2,2.0,NULL),
  (4,'Gravy',2,2.0,NULL),
  (5,'Coke',3,1.0,NULL),
  (6,'Strawberry milkshake',4,3.5,NULL),
  (7,'Cider',5,5.7,NULL),
  (8,'Sea bass puff pie',1,10.5,1),
  (9,'Lemon Meringue pie',1,10.0,2),
  (10,'Kale, Chestnut and Mushroom pie',1,10.5,3),
  (11,'Venison & Bacon pie',1,10.0,1),
  (12,'Pineapple pie',1,10.5,3),
  (13,'Apple pie',1,10.5,3),
  (14,'Feta Spinach pie',1,10.5,3),
  (15,'Mushroom Asparagus pie',1,10.5,3),
  (16,'Chicken & Leek pie',1,10.5,1),
  (17,'Coleslaw',2,2.0,NULL),
  (18,'Chips/Fries',2,2.0,NULL),
  (19,'Mac n Cheese',2,2.0,NULL),
  (20,'Diet coke',3,1.0,NULL),
  (21,'Fanta',3,1.0,NULL),
  (22,'Vanilla milkshake',4,3.5,NULL),
  (23,'Chocolate milkshake',4,3.5,NULL),
  (24,'Lager',5,5.7,NULL);
  CREATE TABLE `ItemTypes` (
  `ID`	INTEGER PRIMARY KEY AUTOINCREMENT UNIQUE,
  `Name`	TEXT UNIQUE
  );
  INSERT INTO `ItemTypes` VALUES (1,'Pies'),
  (2,'Sides'),
  (3,'Soft drinks'),
  (4,'Milkshakes'),
  (5,'Alcohol');
  CREATE TABLE `AccountTypes` (
  `ID`	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,
  `Name`	TEXT NOT NULL
  );
  INSERT INTO `AccountTypes` VALUES (1,'User'),
  (2,'Order handler'),
  (3,'Admin');
SQL
