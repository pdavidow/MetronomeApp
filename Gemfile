source 'https://rubygems.org'

gem 'rails', '3.2.11'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

# gem "moped"
gem "mongoid", "~> 3.0.0"


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'eco'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'
gem 'devise'
gem 'gon', '3.0.5'
gem 'rails_12factor', group: :production   ### HEROKU
gem 'unicorn'
gem 'rails_12factor', group: :production
group :development, :test do
  gem 'jasminerice'

    gem 'capistrano',         require: false
  gem 'capistrano-rvm',     require: false
   gem 'capistrano-rails',   require: false
   gem 'capistrano-bundler', require: false
   gem 'capistrano-unicorn-nginx'
   gem 'sshkit-sudo'
end

gem 'rails-backbone'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'

#####################################################
### uncomment for Heroku:
ruby '2.0.0'
