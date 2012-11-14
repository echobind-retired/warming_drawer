# WarmingDrawer
[![Build Status](https://secure.travis-ci.org/echobind/warming_drawer.png?branch=master)](https://travis-ci.org/echobind/warming_drawer) [![Dependency Status](https://gemnasium.com/echobind/warming_drawer.png)](https://gemnasium.com/echobind/warming_drawer) [![Code Climate](https://codeclimate.com/badge.png)](https://codeclimate.com/github/echobind/warming_drawer)

Warms caches based on a specified urls using an optional background queueing system. For now, only supports Sidekiq or the lack of a queueing system, but in the future will support others.

## Installation

Add this line to your application's Gemfile:

    gem 'warming_drawer'

## Usage
Configure WarmingDrawer:

```ruby
# config/initializers/warming_drawer.rb
WarmingDrawer.configure do |config|
  config.basic_auth_username = ENV['BASIC_AUTH_USER']
  config.basic_auth_password = ENV['BASIC_AUTH_PASS']
  config.queue_name          = ENV['MY_QUEUE_NAME']
  config.queue_system        = :sidekiq
end
```

Pass a set of urls that you want to warm the cache for using either arguments or an array:

```ruby
# using arguments in Rails:
member_urls = members.map{ |m| member_url m }
WarmingDrawer.warm *member_urls

# using an array without Rails:
urls_to_cache = ['http://foo.com', 'http://oof.com']
WarmingDrawer.warm urls_to_cache
```

WarmingDrawer will queue a get request to each url in sequence. Note that in Rails, you must have caching turned on for things to go into the queue.

```ruby
# development.rb
config.action_controller.perform_caching = true
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
