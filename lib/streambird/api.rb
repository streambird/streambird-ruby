require 'uri'
require 'faraday'
require 'json'

class Streambird
  class Api < Struct.new(:api_key, :default_request_params, :logging)
    STREAMBIRD_API_URL = 'http://localhost:11019/v1/'
    STREAMBIRD_GEM_INFO = Gem.loaded_specs["streambird"]
    STREAMBIRD_RUBY_CLIENT_VERSION = STREAMBIRD_GEM_INFO ? STREAMBIRD_GEM_INFO.version.to_s : '0.1.1'.freeze

    def connection
      @connection ||= Faraday.new(:url => STREAMBIRD_API_URL) do |faraday|
        faraday.request :authorization, 'Bearer', self.api_key
        faraday.request  :url_encoded             # form-encode POST params
        faraday.response :logger if logging       # log requests to STDOUT
        faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
      end
    end

    def get(url, params = {})
      response = connection.get do |req|
        req.url "#{STREAMBIRD_API_URL}#{url}"
        req.params.merge!(default_request_params.merge(params))
        req.headers['X-API-Client'] = "Ruby"
        req.headers["X-API-Client-Version"] = STREAMBIRD_RUBY_CLIENT_VERSION
      end

      if response.status != 200
        return handle_error(response)
      end

      response
    rescue Faraday::Error::ConnectionFailed
      raise Streambird::Api::ConnectionError
    end

    def post(url, body = {})
      
      body = default_request_params.merge(body)
      response = connection.post do |req|
        req.url "#{STREAMBIRD_API_URL}#{url}"
        req.headers['Content-Type'] = 'application/json'
        req.body = body.to_json
        req.headers['X-API-Client'] = "Ruby"
        req.headers["X-API-Client-Version"] = STREAMBIRD_RUBY_CLIENT_VERSION
      end

      if response.status != 200 and response.status != 201
        return handle_error(response)
      end

      response
    rescue Faraday::Error::ConnectionFailed
      raise Streambird::Api::ConnectionError
    end


    def delete(url, body = {})
      
      body = default_request_params.merge(body)
      response = connection.delete do |req|
        req.url "#{STREAMBIRD_API_URL}#{url}"
        req.headers['Content-Type'] = 'application/json'
        req.body = body.to_json
        req.headers['X-API-Client'] = "Ruby"
        req.headers["X-API-Client-Version"] = STREAMBIRD_RUBY_CLIENT_VERSION
      end

      if response.status != 200 and response.status != 201
        return handle_error(response)
      end

      response
    rescue Faraday::Error::ConnectionFailed
      raise Streambird::Api::ConnectionError
    end

    def handle_error(response)
      error_body = JSON.parse(response.body)
      if response.status == 404
        raise Streambird::Api::NotFound.new(error_body['error_message'], response.status)
      elsif response.status == 429
        raise Streambird::Api::TooManyRequests.new(error_body['error_message'], response.status)
      elsif response.status > 499
        raise Streambird::Api::InternalServerError.new(error_body['error_message'], response.status)
      elsif response.status == 401
        raise Streambird::Api::Unauthorized.new(error_body['error_message'], response.status)
      else
        raise Streambird::Api::BadRequest.new(error_body['error_message'], response.status)
      end
    rescue JSON::ParserError
      raise Streambird::Api::InternalServerError
    end
  end
end

require 'streambird/api/errors'

