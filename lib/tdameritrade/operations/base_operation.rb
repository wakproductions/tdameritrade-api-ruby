module TDAmeritrade
  module Operations
    class BaseOperation
      # Methods for abstracting HTTP requests; dependency injection for client credentials

      attr_reader :client

      def initialize(client)
        @client = client  # inject dependency of client credentials
      end
    end
  end
end