module TDAmeritrade; module Spec; module Mocks
  class TDAmeritradeMockBase

    API_BASE_URL = 'https://api.tdameritrade.com/v1'

    def self.build_url_params(request)
      # Need to do this to get around a WebMock encoding bug. It's looking for 'APIKEY@AMER.OAUTHAP' when it
      # should be looking for 'APIKEY%40AMER.OAUTHAP'
      if request[:query]
        "?" + request.delete(:query).map { |k,v| "#{k}=#{CGI::escape(v)}" }.join('&')
      else
        ''
      end
    end

    def self.webmock_off?
      WebMock.net_connect_allowed?
    end

  end
end; end; end