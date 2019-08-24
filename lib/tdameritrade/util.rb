require 'tdameritrade/error'
require 'tdameritrade/util_response'

module TDAmeritrade
  module Util
    module_function

    def handle_api_error(response)
      # "Individual App's transactions per seconds restriction, please update to commercial apps for unrestricted tps"
      if response.code == '429'
        raise TDAmeritrade::Error::RateLimitError.new(response.body)
      end

      TDAmeritrade::Error.gem_error("#{response.code} #{response.body}")
    end

    def parse_json_response(response)
      handle_api_error(response) unless UtilResponse.response_success?(response)

      stripped_text = response.body.strip
      sanitized_text = stripped_text[0] == "\\" ? stripped_text[1..-1] : stripped_text
      JSON.parse(sanitized_text)
    end
  end
end