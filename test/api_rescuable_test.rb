require "minitest/autorun"
require_relative "../lib/api_rescuable"

# Ensure backward compatibility with Minitest 4
Minitest::Test = MiniTest::Unit::TestCase unless defined?(Minitest::Test)

require_relative "./support/controllers/api_controller"
require_relative "./support/apps/all_test_app"
require "byebug"

class BugTest < Minitest::Test
  include Rack::Test::Methods

  def test_without_error
    get "/"
    assert last_response.ok?
  end

  def test_record_not_found
    get "/record_not_found"
    assert last_response.not_found?
  end

  def test_record_invalid
    get "/record_invalid"
    assert last_response.unprocessable?
  end

  def test_forbidden_attributes
    get "/forbidden_attributes"
    assert last_response.bad_request?
  end

  def test_parameter_missing
    get "/parameter_missing"
    assert last_response.bad_request?
  end

  def test_access_denied_error
    get "/access_denied"
    assert last_response.unauthorized?
  end

  private

  def app
    Rails.application
  end
end
