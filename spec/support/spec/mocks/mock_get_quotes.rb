require File.join(File.dirname(__FILE__), 'tdameritrade_api_mock_base.rb')

module TDAmeritrade; module Spec; module Mocks;
  class MockGetQuotes < TDAmeritradeMockBase

    def self.mock_find(request: { query: {}, headers: {} }, response: { status: 200, body: '' })
      return if webmock_off?

      url_params = build_url_params(request)
      WebMock
        .stub_request(:get, "#{API_BASE_URL}/marketdata/quotes#{url_params}")
        .with(request)
        .to_return(response)
    end

  end
end; end; end