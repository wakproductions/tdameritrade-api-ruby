require 'spec_helper'
require 'support/authenticated_client'
require 'tdameritrade'

describe TDAmeritrade::Operations::GetWatchlists do
  include_context 'authenticated client'
  # include_context 'webmock off'

  context 'for single account' do
    subject do
      client.get_watchlists(account_id)
    end

    let(:account_id) { '123456789' }

    let!(:expected_request) do
      TDAmeritrade::Spec::Mocks::MockWatchlists.mock_find_for_account(
        account_id,
        request: {
          headers: { 'Authorization': "Bearer #{client.access_token}" },
        },
        response: {
          body: <<~RESPONSE
            [
              {
                "name": "Previous Trades",
                "watchlistId": "666666666",
                "accountId": "123456789",
                "watchlistItems": [
                  {
                    "sequenceId": 1,
                    "quantity": 0.0,
                    "averagePrice": 0.0,
                    "commission": 0.0,
                    "instrument": {
                      "symbol": "BZUN",
                      "assetType": "EQUITY"
                    }
                  },
                  {
                    "sequenceId": 2,
                    "quantity": 0.0,
                    "averagePrice": 0.0,
                    "commission": 0.0,
                    "instrument": {
                      "symbol": "SFLY",
                      "assetType": "EQUITY"
                    }
                  }
                ]
              }
            ]
          RESPONSE
        }
      )
    end

    let(:expected_result) do
      [{"name"=>"Previous Trades",
        "watchlistId"=>"666666666",
        "accountId"=>"123456789",
        "watchlistItems"=>
          [{"sequenceId"=>1,
            "quantity"=>0.0,
            "averagePrice"=>0.0,
            "commission"=>0.0,
            "instrument"=>{"symbol"=>"BZUN", "assetType"=>"EQUITY"}},
           {"sequenceId"=>2,
            "quantity"=>0.0,
            "averagePrice"=>0.0,
            "commission"=>0.0,
            "instrument"=>{"symbol"=>"SFLY", "assetType"=>"EQUITY"}}]}
      ]
    end

    it { is_expected.to eql(expected_result) }
  end


end