class Streambird
  class Api
    class OAuth < Struct.new(:client)
    
      def verify(token:,
        session_type: nil,
        session_token: nil,
        session_expires_in: nil
      )
        req = {
          'token': token,
        }

        req['session_type'] = session_type if !session_type.nil?
        req['session_expires_in'] = session_expires_in if !session_expires_in.nil?
        req['session_token'] = session_token if !session_token.nil?
        response = client.post('auth/oauth/verify', req)
        json_body = JSON.parse(response.body, symbolize_names: true)
        return json_body
      end
    end
  end
end