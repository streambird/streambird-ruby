class Streambird
  class Api
    class Users < Struct.new(:client)
    
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
    end
  end
end