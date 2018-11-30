require 'tdameritrade/error'

module TDAmeritrade
  class Client
    include TDAmeritrade::Authentication
    include TDAmeritrade::Error
    include TDAmeritrade::Instruments

    def initialize(**args)
      @access_token = args[:access_token]
      @refresh_token = args[:refresh_token]
      @client_id = args[:client_id] || gem_error('client_id is required!')
      @redirect_uri = args[:redirect_uri] || gem_error('redirect_uri is required!')
    end
    
  end
end