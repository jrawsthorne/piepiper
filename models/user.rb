class User < ActiveRecord::Base
  include BCrypt
  belongs_to :account_type
  has_many :user_special_conditions
  has_many :orders
  def fullname
    [firstname, lastname].join(' ')
  end
  def get_twitter_user
    return $client.user(twitter_id.to_i) if !twitter_id.nil?
  end
  def get_specials
    return "hi"
  end
  def password
    @password ||= Password.new(password_hash)
  end
  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end
end

class AccountType < ActiveRecord::Base
end
