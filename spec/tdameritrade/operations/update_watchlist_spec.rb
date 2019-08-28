require 'spec_helper'
require 'support/authenticated_client'
require 'tdameritrade'

describe TDAmeritrade::Operations::UpdateWatchlist do
  include_context 'authenticated client'
  # include_context 'webmock off'

  context 'for single account' do
    subject do
      client.update_watchlist(account_id, watchlist_id, 'My New Watchlist', %w(AAPL MSFT VZ))
    end

    let(:account_id) { '123456789' }
    let(:watchlist_id) { '666666666' }

    let!(:expected_request) do
      TDAmeritrade::Spec::Mocks::MockWatchlists.mock_update(
        account_id,
        watchlist_id,
        request: {
          headers: { 'Authorization': "Bearer #{client.access_token}" },
          body: expected_request_body
        }
      )
    end

    let(:expected_request_body) do
      {
        :name=>"My New Watchlist",
        :watchlistId=>"#{watchlist_id}",
        :watchlistItems=>
          [
            {:quantity=>0, :averagePrice=>0, :commission=>0, :purchasedDate=>Date.today.strftime('%Y-%m-%d'), :instrument=>{:symbol=>"AAPL", :assetType=>"EQUITY"}},
            {:quantity=>0, :averagePrice=>0, :commission=>0, :purchasedDate=>Date.today.strftime('%Y-%m-%d'), :instrument=>{:symbol=>"MSFT", :assetType=>"EQUITY"}},
            {:quantity=>0, :averagePrice=>0, :commission=>0, :purchasedDate=>Date.today.strftime('%Y-%m-%d'), :instrument=>{:symbol=>"VZ", :assetType=>"EQUITY"}}
          ]
      }.to_json
    end

    it { is_expected.to be_truthy }
  end


end