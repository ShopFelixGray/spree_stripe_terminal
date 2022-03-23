# encoding: UTF-8
lib = File.expand_path('../lib/', __FILE__)
$LOAD_PATH.unshift lib unless $LOAD_PATH.include?(lib)

require 'spree_stripe_terminal/version'

Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_stripe_terminal'
  s.version     = SpreeStripeTerminal.version
  s.summary     = 'Spree Stripe Terminal'
  s.description = 'Spree Stripe Terminal Payment'
  s.required_ruby_version = '>= 2.1.0'

  s.author    = 'Felix Gray'
  s.email     = 'hoots@shopfelixgray.com'
  s.homepage  = 'https://github.com/your-github-handle/spree_stripe_terminal'
  s.license = 'BSD-3-Clause'

  # s.files       = `git ls-files`.split("\n").reject { |f| f.match(/^spec/) && !f.match(/^spec\/fixtures/) }
  s.require_path = 'lib'
  s.requirements << 'none'

  s.add_dependency 'spree_core', '>= 3.1.10'
  s.add_dependency 'spree_extension'
  s.add_dependency 'stripe'

  s.add_development_dependency 'capybara', '>= 2.6'
  s.add_development_dependency 'coffee-rails'
  s.add_development_dependency 'database_cleaner'
  s.add_development_dependency 'factory_girl', '>= 4.5'
  s.add_development_dependency 'ffaker', '>= 2.2'
  s.add_development_dependency 'rspec-rails', '>= 3.4'
  s.add_development_dependency 'sass-rails', '>= 5.0.0'
  s.add_development_dependency 'selenium-webdriver'
  s.add_development_dependency 'simplecov'
  s.add_development_dependency 'sqlite3'
end
