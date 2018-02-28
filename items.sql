CREATE TABLE items (
  item TEXT NOT NULL,
  item_type TEXT,
  price FLOAT,
  special_condition TEXT
);

INSERT INTO items (item,item_type,price,special_condition)
  SELECT 'Bacon & Egg','Pie', 10.50, 'non-vegetarian'
  UNION SELECT 'Pork','Pie', 10, 'non-vegetarian'
  UNION SELECT 'Lamb shank','Pie',  10, 'non-vegetarian'
  UNION SELECT 'Sea bass Puff','Pie', 10.50, 'vegetarian'
  UNION SELECT 'Lemon Meringue','Pie',  10, 'vegan'
  UNION SELECT 'Kale, Chestnut and Mushroom','Pie',  10.50, 'vegan'
  UNION SELECT 'Venison & Bacon','Pie',  10, 'non-veegtarian'
  UNION SELECT 'Pineapple','Pie',  10.50, 'vegan'
  UNION SELECT 'Apple','Pie',  10.50, 'vegan'
  UNION SELECT 'Feta Spinach','Pie',  10.50, 'vegan'
  UNION SELECT 'Mushroom Asparagus','Pie',  10.50, 'vegan'
  UNION SELECT 'Chicken & Leek','Pie',  10.50, 'non-vegetarian'
  UNION SELECT 'Mushy Peas','Sides', 2,NULL
  UNION SELECT 'Mash','Sides', 2, NULL
  UNION SELECT 'Gravy','Sides', 2, NULL
  UNION SELECT 'Coleslaw','Sides', 2, NULL
  UNION SELECT 'Chips/Fries','Sides', 2, NULL
  UNION SELECT 'Mac n Cheese','Sides', 2, NULL
  UNION SELECT 'Diet coke','Soft drinks', 1,NULL
  UNION SELECT 'Coke','Soft drinks', 1,NULL
  UNION SELECT 'Fanta','Soft drinks', 1,NULL
  UNION SELECT 'Strawberry','Milkshakes', 3.50,NULL
   UNION SELECT 'Vanilla','Milkshakes', 3.50,NULL
   UNION SELECT 'Chocolate','Milkshakes', 3.50,NULL
   UNION SELECT 'Cider','Alcohol', 5.70,NULL
   UNION SELECT 'Lager','Alcohol', 5.70, NULL;
