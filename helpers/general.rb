def current_class?(test_path)
    request.path == test_path ? 'active' : ''
end

def display_error(error)
  return '<div class="col-md-12 error"><div class="alert alert-danger col-sm-12" role="alert">'+error+'</div></div>'
end

def display_success(success)
  return '<div class="col-md-12 success"><div class="alert alert-success col-sm-12" role="alert">'+success+'</div></div>'
end

$errors = {
  :order_not_exist => 'That order doesn\'t exist. <a href="/orders">Go to orders</a>',
  :tweet_not_exist => 'That tweet doesn\'t exist. <a href="/orders">Go to orders</a>',
  :already_order => 'Sorry, that tweet is already linked with an order.',
  :user_not_registered => 'That user isn\'t registered. <a href="/orders">Go to orders</a>'
}

def istweet(tweet_id)
  begin
    tweet = $client.status(tweet_id)
    return true
  rescue Twitter::Error
    return false
  end
end

def get_user_from_tweet(tweet_id)
  return $client.status(tweet_id.to_i).user.id
end

def display_currency(price)
  return format("£%.2f",price)
end
