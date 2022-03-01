class Streambird
  class Api
    class Session < Struct.new(:client)
    
      def verify(session_token:,
        session_expires_in: nil
      )
        req = {
          'session_token': session_token,
        }

        req['session_expires_in'] = session_expires_in if !session_expires_in.nil?
        response = client.post('auth/sessions/verify', req)
        json_body = JSON.parse(response.body, symbolize_names: true)
        return json_body
      end

      def list(user_id:)
        params = {
          'user_id': user_id,
        }

        response = client.get('auth/sessions/list', params)
        json_body = JSON.parse(response.body, symbolize_names: true)
        return json_body
      end
    end
  end
end