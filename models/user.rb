class User
  attr_accessor :id, :username, :password, :twitter_id, :dietry_requirements, :address, :account_type, :firstname, :lastname, :fullname
  def initialize(id = nil, twitter_id = nil, username = nil)
    if(id != nil)
      @twitter_id = $db.get_first_value("SELECT TwitterID FROM Users WHERE ID = CAST(? as INTEGER)",[id])
      @username = $db.get_first_value("SELECT Username FROM Users WHERE ID = CAST(? as INTEGER)",[id])
      @id = id
    elsif(twitter_id != nil)
      @id = $db.get_first_value("SELECT ID FROM Users WHERE TwitterID = CAST(? as TEXT)",[twitter_id])
      @username = $db.get_first_value("SELECT Username FROM Users WHERE TwitterID = CAST(? as TEXT)",[twitter_id])
      @twitter_id = twitter_id
    else
      @id = $db.get_first_value("SELECT ID FROM Users WHERE Username = CAST(? as TEXT)",[username])
      @twitter_id = $db.get_first_value("SELECT TwitterID FROM Users WHERE Username = CAST(? as TEXT)",[username])
      @username = username
    end
    @password = $db.get_first_value("SELECT Password FROM Users WHERE ID = CAST(? as INTEGER)",[@id])
    @dietry_requirements = get_item_special(id: $db.get_first_value("SELECT DietryRequirements FROM Users WHERE ID = CAST(? as INTEGER)",[@id]))
    @address = $db.get_first_value("SELECT Address FROM Users WHERE ID = CAST(? as INTEGER)",[@id])
    @account_type = get_account_type(id: $db.get_first_value("SELECT AccountType FROM Users WHERE ID = CAST(? as INTEGER)",[@id]))
    @firstname = $db.get_first_value("SELECT FirstName FROM Users WHERE ID = CAST(? as INTEGER)",[@id])
    @lastname = $db.get_first_value("SELECT LastName FROM Users WHERE ID = CAST(? as INTEGER)",[@id])
    @fullname = @firstname+" "+@lastname if @lastname
  end
end

class AccountType
  attr_accessor :id, :name
  def initialize(id = nil, name = nil)
    if (id == nil)
      @id = $db.get_first_value("SELECT ID FROM AccountTypes WHERE Name = CAST(? as TEXT)",[name])
      @name = name
    else
      @name = $db.get_first_value("SELECT Name FROM AccountTypes WHERE ID = CAST(? as INTEGER)",[id])
      @id = id
    end
  end
end