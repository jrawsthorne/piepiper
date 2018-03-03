require 'sinatra'
require 'twitter'
require "sqlite3"
require 'json'

enable :sessions

before do
  config = {
      :consumer_key => 'vqJ9GQDOns00WAQx7oDoBJqFX',
      :consumer_secret => 'HmlsBdLGWcZXcFCiidsq74AlLr2XWJnKaO09QPxMWN24ZdpxjK',
      :access_token => '965615031185485824-xCVnWm6q628bwhbLcFjhAsGCpPojDKT',
      :access_token_secret => 'ilEkrfVAahr8odgafGkodNkRl045MbbSgeoicL4x80EB8'
  }
  $client = Twitter::REST::Client.new(config)
  $db = SQLite3::Database.new "piepiper.db"
end

def isorder(tweet_id)
  count = $db.get_first_value("SELECT COUNT(*) FROM Orders WHERE Tweet = CAST(? as TEXT)",[tweet_id])
  return (count == 1)
end

def get_order_ids
  orders = []
  query = $db.prepare "SELECT ID FROM Orders"
  results = query.execute
  while (row = results.next) do
      orders.push(row.join)
  end
  return orders;
  query.close if query
end

class Order
  def initialize(order_id)
    @id = order_id
  end
  def tweet
    tweet_id = $db.get_first_value("SELECT Tweet FROM Orders WHERE ID = CAST(? as TEXT)",[@id])
    return $client.status(tweet_id)
  end
  def items
    items = []
    query = $db.prepare "SELECT Items.ID FROM Items INNER JOIN OrderItems ON OrderItems.Item = Items.ID WHERE `Order` = CAST(? as INTEGER)"
    query.bind_params(@id)
    results = query.execute
    while (row = results.next) do
        item = get_item(row.join)
        items.push(item)
    end
    return items;
    query.close if query
  end
  def delete()
    $db.execute("DELETE FROM OrderItems WHERE `Order` = CAST(? as INTEGER)",[@id])
    $db.execute("DELETE FROM Orders WHERE ID = CAST(? as INTEGER)",[@id])
  end
  def state 
    state = $db.get_first_value("SELECT OrderStates.Name FROM OrderStates INNER JOIN Orders ON Orders.State = OrderStates.ID WHERE Orders.ID = CAST(? as INTEGER)",[@id])
    return state
  end
end

def get_order(order_id)
  return Order.new(order_id)
end

def new_order(items, tweet_id)
  user_id = $client.status(tweet_id).user.id
  # Creates new order
  $db.execute("INSERT INTO Orders (User, Tweet, State) VALUES (?, CAST(? as TEXT), 1)", [user_id, tweet_id])
  new_order_id = $db.last_insert_row_id()
  items.each do |item|
    $db.execute("INSERT INTO OrderItems (`Order`, Item) VALUES (?, (SELECT ID FROM Items WHERE Name = ?))", [new_order_id, item])
  end
end

class Item
  def initialize(item_id)
    @id = item_id
  end
  def name
    name = $db.get_first_value("SELECT Name FROM Items WHERE ID = ?",[@id])
    return name
  end
  def price 
    price = $db.get_first_value("SELECT Price FROM Items WHERE ID = ?",[@id])
    return price
  end
  def type
    type_id = $db.get_first_value("SELECT ItemTypes.ID FROM ItemTypes INNER JOIN Items ON Items.Type = ItemTypes.ID WHERE Items.ID = ?",[@id])
    return get_item_type(type_id)
  end
  def special
    special_id = $db.get_first_value("SELECT SpecialCondition.ID FROM SpecialCondition INNER JOIN Items ON Items.Special = SpecialCondition.ID WHERE Items.ID = ?",[@id])
    return get_item_special(special_id)
  end
end

def get_item(item_id)
  return Item.new(item_id)
end

def get_all_item_names
  items = []
  get_item_ids.each do |item_id|
      items.push(get_item(item_id).name)
  end
  return items
end

def get_item_ids
  items = []
  query = $db.prepare "SELECT ID FROM Items"
  results = query.execute
  while (row = results.next) do
      items.push(row.join)
  end
  return items;
  query.close if query
end

class ItemType
  def initialize(type_id)
    @id = type_id
  end
  def name
    name = $db.get_first_value("SELECT Name FROM ItemTypes WHERE ID = ?",[@id])
    return name
  end
end

def get_item_type(type_id)
  return ItemType.new(type_id)
end

def get_item_type_ids
  types = []
  query = $db.prepare "SELECT ID FROM ItemTypes"
  results = query.execute
  while (row = results.next) do
      types.push(row.join)
  end
  return types;
  query.close if query
end

class Special
  def initialize(special_id)
    @id = special_id
  end
  def name
    name = $db.get_first_value("SELECT Name FROM SpecialCondition WHERE ID = ?",[@id])
    return name
  end
end

def get_item_special(special_id)
  return Special.new(special_id)
end

def get_item_special_ids
  specials = []
  query = $db.prepare "SELECT ID FROM SpecialCondition"
  results = query.execute
  while (row = results.next) do
      specials.push(row.join)
  end
  return specials;
  query.close if query
end

def current_class?(test_path)
    request.path == test_path ? 'active' : ''
end

def authenticate!
    unless session[:user]
      redirect '/login'
    end
end

def authenticated?
    !!session[:user]
end

get '/' do
  @title = "Menu"
  erb :index
end

get '/about' do
  @title = "About Us"
  erb :about
end

get '/login' do
  @title = "Login"
  erb :login
end

post '/login' do
  # Accepts any credentials for now
  session[:user] = "username"
  redirect '/orders'
end

get '/logout' do
  session[:user] = nil
  redirect '/'
end

get '/orders' do
  authenticate!
  @title = "Orders"
  erb :orders
end

post '/new-order/:tweet_id' do
  authenticate!
  new_order(params[:item], params[:tweet_id.to_s])
  redirect '/orders'
end

get '/new-order' do
  authenticate!
  redirect '/orders'
end

get '/new-order/:tweet_id' do
  authenticate!
  @title = "New order"
  erb :'new-order'
end

post '/edit-order/:order_id' do
  authenticate!
  puts params[:item]
  redirect '/orders'
end

get '/edit-order' do
  authenticate!
  redirect '/orders'
end

get '/edit-order/:order_id' do
  authenticate!
  @title = "Edit order"
  erb :'edit-order'
end

get '/delete-order/:order_id' do
  authenticate!
  get_order(params[:order_id]).delete()
  redirect '/orders'
end

get '/delete-order' do
  authenticate!
  redirect '/orders'
end

not_found do
  redirect '/'
end