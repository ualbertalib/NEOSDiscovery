source 'https://rubygems.org'

# Rails stuff
gem 'rails', '5.2.1.1'

# Database stuff
gem 'mysql2', '~> 0.5.2'

# Assets (CSS/JS) stuff
gem 'jquery-rails'
gem 'sass-rails', '~> 5.0'
gem 'turbolinks'
gem 'uglifier', '>= 1.3.0'

# Blacklight stuff
gem 'blacklight', '~> 6.10.1'
gem 'blacklight-marc', '~> 6.0'
gem 'blacklight-ris', git: 'https://github.com/upenn-libraries/blacklight-ris.git'
gem 'blacklight_advanced_search', '>= 6.3'
gem 'blacklight_range_limit'
gem 'rsolr', '~> 2.2'
gem 'traject', '2.3.4'

# Authentication
gem 'devise'
gem 'devise-guests', '~> 0.6'

# Performance monitoring
gem 'rollbar'

# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 1.0.0', group: :doc

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  gem 'sqlite3'
end

group :development do
  gem 'better_errors', '>= 2.3.0'
  gem 'binding_of_caller'
  gem 'brakeman'
  gem 'listen', '~> 3.0'
  gem 'spring'
  gem 'web-console', '~> 3.7'
end
