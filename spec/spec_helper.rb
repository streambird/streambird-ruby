require 'rspec'
require 'webmock/rspec'
require 'vcr'
require 'streambird'
require 'cassettes/custom_serializer'

# by default, rspec use local vcr cassettes to mock client - server
# communication; to run tests against production server (or update
# cassettes), set STREAMBIRD_TEST_API_KEY, and run rspec with
# STREAMBIRD_TEST_SERVER=production, which is encapsulated in rake task
# spec:production
STREAMBIRD_TEST_API_KEY = ENV['STREAMBIRD_TEST_API_KEY'] || 'sk_test_api_key'
STREAMBIRD_TEST_SERVER = ENV['STREAMBIRD_TEST_SERVER'] || 'local'

RSpec.configure do |config|
  config.include WebMock::API
end

VCR.configure do |c|
  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into :webmock
  c.cassette_serializers[:yaml] = Cassettes::CustomSerializer
  c.default_cassette_options = {
    record: STREAMBIRD_TEST_SERVER == 'production' ? :all : :once
  }
end
