class Streambird
  class Api
    class Wallets < Struct.new(:client)

      def begin_registration(wallet_type:,
        public_address:,
        user_id: nil
      )
        req = {
          'wallet_type': wallet_type,
          'public_address': public_address,
        }

        req['user_id'] = user_id if !user_id.nil?
        response = client.post('auth/wallets/registrations/begin', req)
        json_body = JSON.parse(response.body, symbolize_names: true)
        return json_body
      end

      def verify(wallet_type:,
        public_address:,
        signature:
      )
        req = {
          'wallet_type': wallet_type,
          'public_address': public_address,
          'signature': signature,
        }

        response = client.post('auth/wallets/verify', req)
        json_body = JSON.parse(response.body, symbolize_names: true)
        return json_body
      end
    end
  end
end