require 'tdameritrade/error'

module TDAmeritrade
  module Util
    module_function

    def handle_api_error(response)
      # "Individual App's transactions per seconds restriction, please update to commercial apps for unrestricted tps"
      if response.code == 429
        raise TDAmeritrade::Error::RateLimitError.new(response.body)
      elsif response.code == 401
        raise TDAmeritrade::Error::NotAuthorizedError.new(response.body)
      end

      error_message = JSON.parse(response.body)['error']
      raise TDAmeritrade::Error::TDAmeritradeError.new("#{response.code}: #{error_message}")
    rescue JSON::ParserError
      raise TDAmeritrade::Error::TDAmeritradeError.new(
        "Unable to parse error response from TD Ameritrade API: #{response.body}"
      )
    end

    def parse_json_response(response)
      handle_api_error(response) unless response_success?(response)

      stripped_text = response.body.strip
      sanitized_text = stripped_text[0] == "\\" ? stripped_text[1..-1] : stripped_text
      json = JSON.parse(sanitized_text)

      case json
      when Array
        json.map { |item| Hashie::Mash.new(item) }  # assuming that we're only dealing with arrays of hashes
      when Hash
        Hashie::Mash.new(json)
      else
        json
      end

    rescue JSON::ParserError
      raise TDAmeritrade::Error::TDAmeritradeError.new(
        "Unable to parse response from TD Ameritrade API: #{sanitized_text}"
      )
    end
    alias :parse_api_response :parse_json_response

    def response_success?(response)
      response.code.to_s =~ /^2\d\d/
    end
  end
end