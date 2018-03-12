class User < ActiveRecord::Base
  #belongs_to :special_condition
  belongs_to :account_type
  has_many :special_conditions, through: :special_conditions_users
  has_many :special_conditions_users
  has_many :orders
  def fullname
    [firstname, lastname].join(' ')
  end
  def get_twitter_user
    return $client.user(twitter_id.to_i)
  end
  def get_specials
    return "hi"
  end
end

class AccountType < ActiveRecord::Base
end
