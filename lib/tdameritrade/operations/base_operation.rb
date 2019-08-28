require 'tdameritrade/error'
require 'tdameritrade/util'

module TDAmeritrade
  module Operations
    class BaseOperation
      include Util

      HTTP_DEBUG_OUTPUT=ENV['DEBUG_OUTPUT'] # to make live testing easier

      attr_reader :client

      def initialize(client)
        @client = client  # inject dependency of client credentials
      end

      private

      def debug_output?
        HTTP_DEBUG_OUTPUT.to_s == 'true'
      end

      def perform_api_get_request(url: , query: nil)
        options = { headers: { 'Authorization': "Bearer #{client.access_token}" } }
        options.merge!(query: query) if query
        options.merge!(debug_output: $stdout) if debug_output?

        HTTParty.get(
          url,
          options
        )
      end

    end
  end
end