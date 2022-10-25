# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) { |repo_name| "https://github.com/#{repo_name}" }

gem 'rake'

gem 'config'
gem 'fast_jsonapi'
gem 'i18n', require: 'i18n'

gem 'activesupport', require: false

gem 'dry-initializer'
gem 'dry-validation'

gem 'bunny'

group :development do
  gem 'pry'
end

group :development, :test do
  gem 'rubocop', require: false
  gem 'rubocop-rspec', require: false
end

group :test do
  gem 'factory_bot'
  gem 'rspec'
end
