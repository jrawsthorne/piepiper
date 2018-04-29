class User < ActiveRecord::Base
  include BCrypt
  belongs_to :account_type
  has_many :user_special_conditions
  has_many :orders
  has_many :user_campaigns
  belongs_to :location
  def fullname
    [firstname, lastname].join(' ')
  end
  def get_twitter_user
    begin
	    return $client.user(twitter_id.to_i)
	  rescue Twitter::Error
	    return nil
	  end
  end
  def password
    @password ||= Password.new(password_hash)
  end
  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end
  def address
    if(house && street && postcode)
      return house + " " + street + ", " + postcode
    else
      return nil
    end
  end
  def get_id
    return id
  end
  def generate_token
    self.password_reset_token = get_random_string
    self.save
  end
end

class AccountType < ActiveRecord::Base
end
