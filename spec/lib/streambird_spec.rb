require 'securerandom'
require 'streambird/api'
require 'streambird/api/errors'

RSpec.describe Streambird do
  describe '.validate_api_key' do
    it 'rejects short api key' do
      expect{
        Streambird.validate_api_key(SecureRandom.base64(4))
      }.to raise_error Streambird::Api::APIKeyInvalid
    end

    it 'accepts test key' do
      expect{
        Streambird.validate_api_key("sk_test_#{SecureRandom.base64(4)}")
      }.to_not raise_error
    end

    it 'accepts live key' do
      expect{
        Streambird.validate_api_key("sk_live_#{SecureRandom.base64(4)}")
      }.to_not raise_error
    end
  end

  let(:test_client) { Streambird.new(api_key: "sk_test_#{SecureRandom.base64(10)}") }
  let(:live_client) { Streambird.new(api_key: "sk_live_#{SecureRandom.base64(10)}") }

  describe '#test?' do
    it 'recognizes test api' do
      expect(test_client.test?).to be true
      expect(test_client.test).to be true
      expect(test_client.test_mode?).to be true

      expect(live_client.test?).to be false
      expect(live_client.test).to be false
      expect(live_client.test_mode?).to be false
    end
  end

  describe '#live?' do
    it 'recognizes live api' do
      expect(test_client.live?).to be false
      expect(test_client.live).to be false
      expect(test_client.live_mode?).to be false

      expect(live_client.live?).to be true
      expect(live_client.live).to be true
      expect(live_client.live_mode?).to be true
    end
  end
end
