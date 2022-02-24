class Streambird
  attr_accessor :api_key, :default_request_params, :logging

  def self.validate_api_key(api_key)
    if api_key.length < 5 || !(api_key.start_with?('sk_live') || api_key.start_with?('sk_test')) 
      raise Api::APIKeyInvalid
    end
  end

  def initialize(api_key: nil, default_request_params: {}, logging: false)
    Streambird.validate_api_key(api_key)

    self.api_key = api_key
    self.default_request_params = default_request_params
    self.logging = logging
  end

  def live?
    api_key.start_with?('sk_live')
  end

  def test?
    api_key.start_with?('sk_test')
  end

  def client
    @client ||= Api.new(api_key, default_request_params, logging)
  end

  def magic_links
    @magic_links ||= Streambird::Api::MagicLinks.new(client)
  end

  def otps
    @otps ||= Streambird::Api::Otps.new(client)
  end

  def users
    @users ||= Streambird::Api::Users.new(client)
  end

  def oauth
    @oauth ||= Streambird::Api::OAuth.new(client)
  end


  alias_method :live, :live?
  alias_method :test, :test?
  alias_method :live_mode?, :live?
  alias_method :test_mode?, :test?
end

require 'streambird/api'
require 'streambird/api/errors'
require 'streambird/api/magic_links'
require 'streambird/api/otps'
require 'streambird/api/users'
require 'streambird/api/oauth'
