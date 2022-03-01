class Streambird
  class Api
    class OAuthConnection < Struct.new(:client)
    
      def create(provider:,
        client_id:,
        client_secret: nil,
        team_id: nil,
        key_id: nil,
        private_key: nil,
        domain: nil
      )
        req = {
          'provider': provider,
          'client_id': client_id,
        }

        req['client_secret'] = client_secret if !client_secret.nil?
        req['team_id'] = team_id if !team_id.nil?
        req['key_id'] = key_id if !key_id.nil?
        req['private_key'] = private_key if !private_key.nil?
        req['domain'] = domain if !domain.nil?
        response = client.post('auth/oauth_connections/create', req)
        json_body = JSON.parse(response.body, symbolize_names: true)
        return json_body
      end

      def update(oauth_connection_id:,
        client_id: nil,
        client_secret: nil,
        team_id: nil,
        key_id: nil,
        private_key: nil,
        domain: nil
      )
        req = {}
        req['client_id'] = client_id if !client_id.nil?
        req['client_secret'] = client_secret if !client_secret.nil?
        req['team_id'] = team_id if !team_id.nil?
        req['key_id'] = key_id if !key_id.nil?
        req['private_key'] = private_key if !private_key.nil?
        req['domain'] = domain if !domain.nil?
        response = client.put("auth/oauth_connections/#{oauth_connection_id}/update", req)
        json_body = JSON.parse(response.body, symbolize_names: true)
        return json_body
      end

      def get(oauth_connection_id)
        response = client.get("auth/oauth_connections/#{oauth_connection_id}")
        json_body = JSON.parse(response.body, symbolize_names: true)
        return json_body
      end

      def delete(oauth_connection_id)
        response = client.delete("auth/oauth_connections/#{oauth_connection_id}/delete")
        json_body = JSON.parse(response.body, symbolize_names: true)
        return json_body
      end
    end
  end
end