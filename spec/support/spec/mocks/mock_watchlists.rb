require File.join(File.dirname(__FILE__), 'tdameritrade_api_mock_base.rb')

module TDAmeritrade; module Spec; module Mocks;
class MockWatchlists < TDAmeritradeMockBase

  def self.mock_create(account_id, request: { headers: {} }, response: { status: 200, body: '' } )
    return if webmock_off?

    WebMock
      .stub_request(:post, "#{API_BASE_URL}/accounts/#{account_id}/watchlists")
      .with(request)
      .to_return(response)
  end

  def self.mock_find_for_account(account_id, request: { headers: {} }, response: { status: 200, body: '' })
    return if webmock_off?

    WebMock
      .stub_request(:get, "#{API_BASE_URL}/accounts/#{account_id}/watchlists")
      .with(request)
      .to_return(response)
  end

end
end; end; end