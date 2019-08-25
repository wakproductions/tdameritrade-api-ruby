module TDAmeritrade
  module Operations
    class BaseOperation
      include Util

      HTTP_DEBUG_OUTPUT=true # only set this to true for testing

      attr_reader :client

      def initialize(client)
        @client = client  # inject dependency of client credentials
      end

      private

      def debug_output?
        HTTP_DEBUG_OUTPUT
      end

      def perform_api_get_request(url: , query: )
        HTTParty.get(
          url,
          headers: { 'Authorization': "Bearer #{client.access_token}" },
          query: query,
          debug_output: debug_output? ? $stdout : $stderr
        )
      end

    end
  end
end