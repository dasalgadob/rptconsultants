source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.6'
# Use postgresql as the database for Active Record
gem 'pg', '~> 1.2.3'
# Use Puma as the app server
gem 'puma', '~> 3.0'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 6.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
#gem 'turbolinks', '~> 5.0.0'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
gem 'bcrypt' , '~> 3.1.12'
#gem 'bcrypt', platforms: :ruby
# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
  #gem 'factory_bot_rails'
  gem 'spring'

  gem 'factory_bot_rails'

end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
end

group :test do
  gem 'rails-controller-testing'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]



gem 'bootstrap-sass'

gem 'will_paginate'

gem 'jquery-ui-rails'

#gem 'rails4-autocomplete'
gem 'rails-jquery-autocomplete'

gem "font-awesome-rails"
#gem 'axlsx'
#gem 'axlsx_rails'
#gem 'spreadsheet'
gem "roo", "~> 2.7.1"

#gem 'searchlogic'
gem 'has_scope'
#Gem for serialization to be able to use the objets through an API
gem 'fast_jsonapi'

#Gem to add authorization
gem 'cancancan', '~> 2.0'

#vulnerability with precompile assets
gem 'sprockets', '~>3.7.2'

gem 'rubyzip', '>= 1.2.1'
gem 'axlsx', git: 'https://github.com/randym/axlsx.git', ref: 'c8ac844'
gem 'axlsx_rails' ##To export excel files

gem "seedbank" #Gem to allow execution of custom seeds
gem 'mimemagic', github: 'mimemagicrb/mimemagic', ref: '01f92d86d15d85cfd0f20dabd025dcbd36a8a60f' #To Solve
#Your bundle is locked to mimemagic (0.3.2), but that version could not be found
#in any of the sources listed in your Gemfile. If you haven't changed sources,
#that means the author of mimemagic (0.3.2) has removed it. You'll need to update
#your bundle to a version other than mimemagic (0.3.2) that hasn't been removed
#in order to install.
gem 'concurrent-ruby', '~> 1.1.9'
