class User < ActiveRecord::Base
  include BCrypt
  belongs_to :account_type
  has_many :user_special_conditions
  has_many :orders
  has_many :user_campaigns
  belongs_to :location

  #Returns the user's full name
  def fullname
    [firstname, lastname].join(' ')
  end

  #Returns the user's twitter user ID
  def get_twitter_user
    begin
	    return $client.user(twitter_id.to_i)
	  rescue Twitter::Error
	    return nil
	  end
  end

  #Sets a new password hash
  def password
    @password ||= Password.new(password_hash)
  end

  #Sets the user's new password
  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

  #Returns the user's address
  def address
    if(house && street && postcode)
      return house + " " + street + ", " + postcode
    else
      return nil
    end
  end

  #Returns the user's ID
  def get_id
    return id
  end

  #Saves the new password
  def change_password(password)
    self.password = password
    self.save
  end

  #Sets the user's password reset token
  def generate_token
    self.password_reset_token = get_random_string
    self.save
  end

  #Removes the password reset token
  def remove_token
    self.password_reset_token = nil
    self.save
  end
end

class AccountType < ActiveRecord::Base
end
