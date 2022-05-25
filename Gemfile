source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.4'

gem 'rails', '~> 7.0.2', '>= 7.0.2.4'

gem 'bootsnap', require: false
gem 'cssbundling-rails', '~> 1.1.0'
gem 'dotenv-rails', '~> 2.5'
gem 'image_processing', '~> 1.12.2'
gem 'jsbundling-rails', '~> 1.0.2'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'roo', '~> 2.9.0', github: 'roo-rb/roo'
gem 'simple_command', '~> 0.1.0'
gem 'simple_form', '~> 5.1.0'
gem 'sprockets-rails', '~> 3.4.2'
gem 'stimulus-rails', '~> 1.0.4'
gem 'turbo-rails', '~> 1.0.1'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

group :development, :test do
  gem 'debug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails', '~> 6.2.0'
  gem 'rspec-rails', '~> 5.1.2'
end

group :development do
  gem 'rubocop', '~> 1.23.0', require: false
  gem 'rubocop-rails', '~> 2.12.4', require: false
  gem 'web-console', '~> 4.2.0'
end

group :test do
  gem 'database_cleaner', '~> 2.0.1'
  gem 'shoulda-matchers', '~> 5.1.0'
  gem 'simplecov', '~> 0.21.2'
end
