# Spree Stripe Terminal

This gem allows you to process payments with the stripe terminal via the backend of spree. Make sure to register the reader with the stripe dashboard before you begin.

## Installation

1. Add this extension to your Gemfile with this line:
  ```ruby
  gem 'spree_stripe_terminal', github: 'ShopFelixGray/spree_stripe_terminal'
  ```

2. Install the gem using Bundler:
  ```ruby
  bundle install
  ```

3. Copy & run migrations
  ```ruby
  bundle exec rails g spree_stripe_terminal:install
  ```

4. Add a stripe.rb file to your application config/initializers folder with the following information:
   ```ruby
   require 'stripe'
   Stripe.api_key = YOUR_STRIPE_API_KEY
   Stripe.api_version = '2019-05-16'
   ```

4. Restart your server

  If your server was running, restart it so that it can find the assets properly.

## Testing

First bundle your dependencies, then run `rake`. `rake` will default to building the dummy app if it does not exist, then it will run specs. The dummy app can be regenerated by using `rake test_app`.

```shell
bundle
bundle exec rake
```

When testing your applications integration with this extension you may use it's factories.
Simply add this require statement to your spec_helper:

```ruby
require 'spree_stripe_terminal/factories'
```


## Contributing

If you'd like to contribute, please take a look at the
[instructions](CONTRIBUTING.md) for installing dependencies and crafting a good
pull request.

Copyright (c) 2020 Houtan Fanisalek (Felix Gray, Inc.), released under the New BSD License
