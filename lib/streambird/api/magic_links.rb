class Streambird
  class Api
    class MagicLinks < Struct.new(:client)
      
      def email
        @email ||= Streambird::Api::MagicLinks::Email.new(client)
      end

      def create(user_id:)
        req = {
          'user_id': user_id,
        }
        response = client.post('auth/magic_links/create', req)
        json_body = JSON.parse(response.body, symbolize_names: true)
        return json_body
      end

      def verify(token:,
        session_token: nil,
        session_expires_in: nil,
        device_fingerprint: {}
      )
        req = {
          'token': token,
        }

        req['device_fingerprint'] = device_fingerprint if device_fingerprint != {}
        req['session_expires_in'] = session_expires_in if !session_expires_in.nil?
        req['session_token'] = session_token if !session_token.nil?
        response = client.post('auth/magic_links/verify', req)
        json_body = JSON.parse(response.body, symbolize_names: true)
        return json_body
      end

      class Email < Struct.new(:client)

        def login_or_create(email:,
          login_redirect_url: nil,
          registration_redirect_url: nil,
          login_expires_in: nil,
          registration_expires_in: nil,
          requires_verification: nil,
          device_fingerprint: {}
        )

          req = {
            'email': email,
          }

          req['login_redirect_url'] = login_redirect_url if !login_redirect_url.nil?
          req['registration_redirect_url'] = registration_redirect_url if !registration_redirect_url.nil?
          req['registration_expires_in'] = registration_expires_in if !registration_expires_in.nil?
          req['login_expires_in'] = login_expires_in if !login_expires_in.nil?
          req['requires_verification'] = requires_verification if !requires_verification.nil?
          req['device_fingerprint'] = device_fingerprint if device_fingerprint != {}
          response = client.post('auth/magic_links/email/login_or_create', req)

          json_body = JSON.parse(response.body, symbolize_names: true)
          return json_body
        end
      end
    end
  end
end