#Highlights active page in nav bar
def current_class?(test_path)
    request.path == test_path ? 'active' : ''
end

#Returns a HTML div containing a error message passed to it, with styling showing what type of message it is
def display_error(error)
  return '<div class="col-md-12 error"><div class="alert alert-danger col-sm-12" role="alert">'+error+'</div></div>'
end

#Returns a HTML div containing a message passed to it, with styling showing what type of message it is
def display_success(success)
  return '<div class="col-md-12 success"><div class="alert alert-success col-sm-12" role="alert">'+success+'</div></div>'
end

#List of possible error messages
$errors = {
  :order_not_exist => 'That order doesn\'t exist. <a href="/orders">Go to orders</a>',
  :tweet_not_exist => 'That tweet doesn\'t exist. <a href="/orders">Go to orders</a>',
  :already_order => 'Sorry, that tweet is already linked with an order.',
  :user_not_registered => 'That user isn\'t registered. <a href="/orders">Go to orders</a>'
}

#Checks if a passed tweet ID matches to a real tweet
def istweet(tweet_id)
  begin
    tweet = $client.status(tweet_id)
    return true
  rescue Twitter::Error
    return false
  end
end

#Returns the user that authored a tweet
def get_user_from_tweet(tweet_id)
  begin
    return $client.status(tweet_id.to_i).user.id
  rescue Twitter::Error
    return nil
  end
end

#Returns a formatted string version of the passed price
def display_currency(price)
  return format("£%.2f",price)
end
