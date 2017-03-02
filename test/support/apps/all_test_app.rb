require "rack/test"
require "action_controller/railtie"

class AllTestApp < Rails::Application
  config.root = File.dirname(__FILE__)
  config.session_store :cookie_store, key: "cookie_store_key"
  secrets.secret_token    = "secret_token"
  secrets.secret_key_base = "secret_key_base"

  config.logger = Logger.new($stdout)
  Rails.logger  = config.logger

  routes.draw do
    get "/" => "api#index"
    get "/record_not_found" => "api#record_not_found"
    get "/record_invalid" => "api#record_invalid"
    get "/forbidden_attributes" => "api#forbidden_attributes"
    get "/parameter_missing" => "api#parameter_missing"
    get "/access_denied" => "api#access_denied"
  end
end
