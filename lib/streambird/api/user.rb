class Streambird
  class Api
    class User < Struct.new(:client)
    
      def create(email: nil, 
        phone_number: nil,
        first_name: nil,
        middle_name: nil,
        last_name: nil,
        requires_verification: nil
      )
        req = {}
        req['email'] = email if !email.nil?
        req['phone_number'] = phone_number if !phone_number.nil?
        req['first_name'] = first_name if !first_name.nil?
        req['middle_name'] = middle_name if !middle_name.nil?
        req['last_name'] = last_name if !last_name.nil?
        req['requires_verification'] = requires_verification if !requires_verification.nil?

        response = client.post('auth/users/create', req)
        json_body = JSON.parse(response.body, symbolize_names: true)
        return json_body
      end

      def update(user_id:, 
        first_name: nil,
        middle_name: nil,
        last_name: nil,
        emails: [],
        phone_numbers: []
      )
        req = {}
        req['first_name'] = first_name if !first_name.nil?
        req['middle_name'] = middle_name if !middle_name.nil?
        req['last_name'] = last_name if !last_name.nil?
        req['emails'] = to_emails_req(emails)
        req['phone_numbers'] = to_phone_numbers_req(phone_numbers)

        response = client.put("auth/users/#{user_id}/update", req)
        json_body = JSON.parse(response.body, symbolize_names: true)
        return json_body
      end

      def get(user_id:)
        response = client.get("auth/users/#{user_id}")
        json_body = JSON.parse(response.body, symbolize_names: true)
        return json_body
      end

      def delete(user_id:)
        response = client.delete("auth/users/#{user_id}/delete")
        json_body = JSON.parse(response.body, symbolize_names: true)
        return json_body
      end

      def delete_email(email_id:)
        response = client.delete("auth/users/emails/#{email_id}/delete")
        json_body = JSON.parse(response.body, symbolize_names: true)
        return json_body
      end

      def delete_phone_number(phone_number_id:)
        response = client.delete("auth/users/phone_numbers/#{phone_number_id}/delete")
        json_body = JSON.parse(response.body, symbolize_names: true)
        return json_body
      end

      def to_emails_req(emails)
        emails_req = []
        emails.each do |email|
          emails_req << { email: email }
        end
        emails_req
      end

      def to_phone_numbers_req(phone_numbers)
        phone_numbers_req = []
        phone_numbers.each do |phone_number|
          phone_numbers_req << { phone_number: phone_number }
        end
        phone_numbers_req
      end
    end
  end
end