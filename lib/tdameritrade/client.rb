require 'tdameritrade/authentication'
require 'tdameritrade/client'
require 'tdameritrade/error'
require 'tdameritrade/instruments'
require 'tdameritrade/watchlists'
require 'tdameritrade/version'
require 'tdameritrade/operations/get_price_history'

module TDAmeritrade
  class Client
    include TDAmeritrade::Authentication
    include TDAmeritrade::Error
    include TDAmeritrade::Instruments
    include TDAmeritrade::Watchlists

    def initialize(**args)
      @access_token = args[:access_token]
      @refresh_token = args[:refresh_token]
      @client_id = args[:client_id] || Error.gem_error('client_id is required!')
      @redirect_uri = args[:redirect_uri] || Error.gem_error('redirect_uri is required!')
    end

    def get_price_history(symbol, **options)
      Operations::GetPriceHistory.new(self).call(symbol, options)
    end

  end
end