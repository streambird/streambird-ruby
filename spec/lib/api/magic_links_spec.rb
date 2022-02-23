RSpec.describe Streambird::Api::MagicLinks do
  let(:streambird) { Streambird.new(api_key: STREAMBIRD_TEST_API_KEY) }
  let(:login_or_create_resp) do
    # reuse cassette from magic_links_create
    VCR.use_cassette('magic_links_create') do
      streambird.magic_links.create({'user_id': 'user_25D4DEomNH7ECF3OyZweqx0B4Q7'})
    end
  end

  describe '#create' do
    context 'with valid user id' do
      it 'contains the user_id' do
        expect(login_or_create_resp[:user_id]).to eq 'user_25D4DEomNH7ECF3OyZweqx0B4Q7'
      end
    end
  end
end
