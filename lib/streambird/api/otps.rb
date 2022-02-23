class Streambird
  class Api
    class Otps < Struct.new(:client)
      
      def email
        @email ||= Streambird::Api::Otps::Email.new(client)
      end

      def sms
        @sms ||= Streambird::Api::Otps::Sms.new(client)
      end

      def verify(otp:,
        method_id:,
        session_token: nil,
        session_expires_in: nil,
        device_fingerprint: {}
      )
        req = {
          'otp': otp,
          'method_id': method_id,
        }

        req['device_fingerprint'] = device_fingerprint if device_fingerprint != {}
        req['session_expires_in'] = session_expires_in if !session_expires_in.nil?
        req['session_token'] = session_token if !session_token.nil?
        response = client.post('auth/otps/verify', req)
        json_body = JSON.parse(response.body, symbolize_names: true)
        return json_body
      end

      class Email < Struct.new(:client)

        def login_or_create(email:,
          expires_in: nil,
          requires_verification: nil,
          device_fingerprint: {}
        )

          req = {
            'email': email,
          }

          req['expires_in'] = expires_in if !expires_in.nil?
          req['requires_verification'] = requires_verification if !requires_verification.nil?
          req['device_fingerprint'] = device_fingerprint if device_fingerprint != {}
          response = client.post('auth/otps/email/login_or_create', req)

          json_body = JSON.parse(response.body, symbolize_names: true)
          return json_body
        end

        def send(email:,
          expires_in: nil,
          device_fingerprint: {}
        )

          req = {
            'email': email,
          }

          req['expires_in'] = expires_in if !expires_in.nil?
          req['device_fingerprint'] = device_fingerprint if device_fingerprint != {}
          response = client.post('auth/otps/email/send', req)

          json_body = JSON.parse(response.body, symbolize_names: true)
          return json_body
        end
      end

      class Sms < Struct.new(:client)

        def login_or_create(phone_number:,
          expires_in: nil,
          requires_verification: nil,
          device_fingerprint: {}
        )

          req = {
            'phone_number': phone_number,
          }

          req['expires_in'] = expires_in if !expires_in.nil?
          req['requires_verification'] = requires_verification if !requires_verification.nil?
          req['device_fingerprint'] = device_fingerprint if device_fingerprint != {}
          response = client.post('auth/otps/sms/login_or_create', req)

          json_body = JSON.parse(response.body, symbolize_names: true)
          return json_body
        end

        def send(phone_number:,
          expires_in: nil,
          device_fingerprint: {}
        )

          req = {
            'phone_number': phone_number,
          }

          req['expires_in'] = expires_in if !expires_in.nil?
          req['device_fingerprint'] = device_fingerprint if device_fingerprint != {}
          response = client.post('auth/otps/sms/send', req)

          json_body = JSON.parse(response.body, symbolize_names: true)
          return json_body
        end
      end
    end
  end
end