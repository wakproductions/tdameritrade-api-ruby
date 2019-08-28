require 'tdameritrade/operations/base_operation'

module TDAmeritrade; module Operations
  class GetInstrumentFundamentals < BaseOperation

    def call(symbol)
      params = {
        apikey: client.client_id,
        symbol: symbol,
        projection: 'fundamental'
      }

      response = perform_api_get_request(
        url: 'https://api.tdameritrade.com/v1/instruments',
        query: params,
      )

      parse_api_response(response)
    end

  end
end; end