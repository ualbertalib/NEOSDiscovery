source 'https://rubygems.org'

# Rails stuff
gem 'rails', '~> 5.2.6'
gem 'sprockets', '< 5.0'

# Database stuff
gem 'mysql2', '~> 0.5.3'

# Assets (CSS/JS) stuff
gem 'jquery-rails'
gem 'sassc-rails', '~> 2.1'
gem 'turbolinks'
gem 'uglifier', '>= 1.3.0'

# Blacklight stuff
gem 'blacklight', '~> 6.10.1'
gem 'blacklight-marc', '~> 6.0'
gem 'blacklight-ris', git: 'https://github.com/upenn-libraries/blacklight-ris.git'
gem 'blacklight_advanced_search', '>= 6.3'
gem 'blacklight_range_limit'
gem 'rsolr', '~> 2.4'
gem 'traject', '2.3.4'

# Authentication
gem 'devise'
gem 'devise-guests', '~> 0.8'

# Performance monitoring
gem 'rollbar'

# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 2.2.0', group: :doc

group :development, :test do
  gem 'rspec-rails', '~> 5.0'
  gem 'capybara', '>= 2.4.0'
  gem 'vcr', '5.0'
  gem 'webmock'

  gem 'pry'
  gem 'pry-byebug'
  gem 'pry-rails'

  gem 'sqlite3', '~> 1.4.2' # Active Record has a version constraint not specified in gemspec
end

group :development do
  gem 'better_errors', '>= 2.3.0'
  gem 'binding_of_caller'
  gem 'brakeman'
  gem 'listen', '~> 3.7'
  gem 'spring'
  gem 'web-console', '~> 3.7'
end
