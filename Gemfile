source 'https://rubygems.org'

# gem 'rails' # we don't want to load activerecord so we can't require rails
gem 'railties'
gem 'actionpack'
gem 'actionmailer'
gem 'activemodel'

# couch
gem 'couch_potato', :git => 'git@github.com:langalex/couch_potato.git'
gem 'tzinfo' # cause needed by activesupport but required by activerecord

# markup
gem 'haml'

#auth
gem 'omniauth'
gem 'omniauth-identity'


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'bootstrap-sass'
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

group :development, :test do
  gem 'capybara'        # running tests against rack
  gem 'rspec-rails'     # rspec for rails
  gem 'capybara-webkit' # webkit driver for capybara - runs headless
  gem 'guard-rspec'     # for autotest
  gem 'rb-fsevent'
  gem 'database_cleaner'# to clean test data after test runs
end

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'
