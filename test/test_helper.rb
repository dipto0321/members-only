ENV["RAILS_ENV"] = "test"
require File.expand_path("../../config/environment", __FILE__)
require "rails/test_help"
require "minitest/rails"
require 'minitest/reporters'
require 'database_cleaner'

Minitest::Reporters.use!(
  Minitest::Reporters::ProgressReporter.new,
  ENV,
  Minitest.backtrace_filter
)

module AroundEachTest
  def before_setup
    super
    DatabaseCleaner.clean 
    DatabaseCleaner.start    
  end
end

DatabaseCleaner.strategy = :transaction

# To add Capybara feature tests add `gem "minitest-rails-capybara"`
# to the test group in the Gemfile and uncomment the following:
# require "minitest/rails/capybara"

# Uncomment for awesome colorful output
# require "minitest/pride"

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all
  # Add more helper methods to be used by all tests here...
  ActiveRecord::Migration.check_pending!

  def is_signed_in?
    !session[:user_id].nil?
  end

  def sign_in_as(user)
    session[:user_id] = user.id
  end
end

class ActionDispatch::IntegrationTest
  def sign_in_as(user, password: 'password')
    post signin_path, params: {sessions: {email: user.email, password: password}}
  end
end
