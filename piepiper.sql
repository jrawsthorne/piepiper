CREATE TABLE IF NOT EXISTS `users` (
`id`	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,
`username`	TEXT NOT NULL UNIQUE,
`firstname`	TEXT NOT NULL,
`lastname`	TEXT NOT NULL,
`password`	TEXT NOT NULL,
`twitter_id`	TEXT NOT NULL UNIQUE,
`special_condition_id`	INTEGER,
`address`	TEXT NOT NULL,
`account_type_id`	INTEGER NOT NULL,
FOREIGN KEY(`account_type_id`) REFERENCES `account_types`(`id`),
FOREIGN KEY(`special_condition_id`) REFERENCES `special_conditions`(`id`)
);
INSERT INTO `users` VALUES (1,'collin602','Collin','Coutinho','password','226319377',NULL,'S10 3AU',1);
CREATE TABLE IF NOT EXISTS `special_conditions` (
`id`	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,
`name`	TEXT NOT NULL UNIQUE
);
INSERT INTO `special_conditions` VALUES (1,'Non-vegetarian'),
(2,'Vegan'),
(3,'Vegetarian'),
(4,'Gluten free');
CREATE TABLE IF NOT EXISTS `orders` (
`id`	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,
`user_id`	INTEGER NOT NULL,
`tweet`	TEXT NOT NULL,
`state_id`	INTEGER NOT NULL,
FOREIGN KEY(`user_id`) REFERENCES `users`(`id`),
FOREIGN KEY(`state_id`) REFERENCES `order_states`(`id`)
);
CREATE TABLE IF NOT EXISTS `order_states` (
`id`	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,
`name`	TEXT
);
INSERT INTO `order_states` VALUES (1,'Preparing'),
(2,'Complete');
CREATE TABLE IF NOT EXISTS `order_items` (
`id`	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,
`order_id`	INTEGER NOT NULL,
`item_id`	INTEGER NOT NULL,
`quantity`	INTEGER NOT NULL DEFAULT 1,
FOREIGN KEY(`item_id`) REFERENCES `items`(`id`),
FOREIGN KEY(`order_id`) REFERENCES `orders`(`id`)
);
CREATE TABLE IF NOT EXISTS `items` (
`id`	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,
`name`	TEXT NOT NULL UNIQUE,
`item_type_id`	INTEGER NOT NULL,
`price`	FLOAT,
`special_condition_id`	INTEGER,
FOREIGN KEY(`special_condition_id`) REFERENCES `special_conditions`(`id`),
FOREIGN KEY(`item_type_id`) REFERENCES `item_types`(`id`)
);
INSERT INTO `items` VALUES (1,'Pork pie',1,10.0,1),
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
CREATE TABLE IF NOT EXISTS `item_types` (
`id`	INTEGER PRIMARY KEY AUTOINCREMENT UNIQUE,
`name`	TEXT UNIQUE
);
INSERT INTO `item_types` VALUES (1,'Pies'),
(2,'Sides'),
(3,'Soft drinks'),
(4,'Milkshakes'),
(5,'Alcohol');
CREATE TABLE IF NOT EXISTS `account_types` (
`id`	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,
`name`	TEXT NOT NULL
);
INSERT INTO `account_types` VALUES (1,'User'),
(2,'Order handler'),
(3,'Admin');