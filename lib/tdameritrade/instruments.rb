require 'tdameritrade/util'
require 'httparty'

module TDAmeritrade
  module Instruments

    def get_instrument_fundamentals(symbol)
      params = {
        apikey: client_id,
        symbol: symbol,
        projection: 'fundamental'
      }

      response = HTTParty.get(
        'https://api.tdameritrade.com/v1/instruments',
        headers: { 'Authorization': "Bearer #{access_token}" },
        query: params
      )

      Util.parse_json_response(response)
    end
  end
end