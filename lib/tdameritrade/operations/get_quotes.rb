require 'tdameritrade/operations/base_operation'

module TDAmeritrade; module Operations
  class GetQuotes < BaseOperation

    def call(symbols: [])
      params = {
        apikey: client.client_id,
        symbol: symbols.join(','),
      }

      response = perform_api_get_request(
        url: "https://api.tdameritrade.com/v1/marketdata/quotes",
        query: params,
      )

      parse_api_response(response)
    end

  end
end; end