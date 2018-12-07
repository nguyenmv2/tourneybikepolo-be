# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

gem "bcrypt", "~> 3.1.7"
gem "bootsnap", ">= 1.1.0", require: false
gem "knock"
gem "money-rails", "~>1"
gem "pg", ">= 0.18", "< 2.0"
gem "puma", "~> 3.11"
gem "rack-cors", require: "rack/cors"
gem "rails", "~> 5.2.0"
gem "sidekiq"
gem "stripe", "~> 3.17.0"

group :development, :test do
  gem "byebug", platforms: %i[mri mingw x64_mingw]
  gem "factory_bot_rails"
  gem "faker"
  gem "pry-rails"
  gem "rspec-rails"
  gem "rubocop"
  gem "shoulda-matchers", git: "https://github.com/thoughtbot/shoulda-matchers.git", tag: "v4.0.0.rc1"
  gem "simplecov", require: false
  gem "stripe-ruby-mock", "~> 2.5.4", require: "stripe_mock"
end

group :development do
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "rails-erd"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
end

gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]
