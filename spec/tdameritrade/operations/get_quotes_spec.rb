require 'spec_helper'
require 'support/authenticated_client'
require 'tdameritrade'

describe TDAmeritrade::Operations::GetQuotes do
  include_context 'authenticated client'
  # include_context 'webmock off'

  context 'valid symbol' do
    subject do
      client.get_quotes(symbols)
    end

    let(:symbols) { %w(PG MSFT CVX) }

    let!(:expected_request) do
      TDAmeritrade::Spec::Mocks::MockGetQuotes.mock_find(
        request: {
          headers: { 'Authorization': "Bearer #{client.access_token}" },
          query: {
            apikey: client.client_id,
            symbol: symbols.join(','),
          }.map {|k,v| [k, v.to_s] }.to_h,
        },
        response: {
          body: <<~RESPONSE
            {
              "PG": {
                "assetType": "EQUITY",
                "symbol": "PG",
                "description": "Procter & Gamble Company (The) Common Stock",
                "bidPrice": 120.55,
                "bidSize": 500,
                "bidId": "P",
                "askPrice": 120.99,
                "askSize": 500,
                "askId": "P",
                "lastPrice": 120.55,
                "lastSize": 0,
                "lastId": "N",
                "openPrice": 119.99,
                "highPrice": 121.05,
                "lowPrice": 119.78,
                "bidTick": " ",
                "closePrice": 119.32,
                "netChange": 1.23,
                "totalVolume": 6996550,
                "quoteTimeInLong": 1566950400020,
                "tradeTimeInLong": 1566945034633,
                "mark": 120.55,
                "exchange": "n",
                "exchangeName": "NYSE",
                "marginable": true,
                "shortable": true,
                "volatility": 0.01,
                "digits": 2,
                "52WkHigh": 121.76,
                "52WkLow": 78.49,
                "nAV": 0.0,
                "peRatio": 79.1467,
                "divAmount": 2.9836,
                "divYield": 2.5,
                "divDate": "2019-07-18 00:00:00.000",
                "securityStatus": "Normal",
                "regularMarketLastPrice": 120.55,
                "regularMarketLastSize": 12155,
                "regularMarketNetChange": 1.23,
                "regularMarketTradeTimeInLong": 1566945000012,
                "netPercentChangeInDouble": 1.0308,
                "markChangeInDouble": 1.23,
                "markPercentChangeInDouble": 1.0308,
                "regularMarketPercentChangeInDouble": 1.0308,
                "delayed": false
              },
              "MSFT": {
                "assetType": "EQUITY",
                "symbol": "MSFT",
                "description": "Microsoft Corporation - Common Stock",
                "bidPrice": 135.87,
                "bidSize": 500,
                "bidId": "K",
                "askPrice": 136.06,
                "askSize": 200,
                "askId": "Q",
                "lastPrice": 136.04,
                "lastSize": 200,
                "lastId": "D",
                "openPrice": 136.39,
                "highPrice": 136.72,
                "lowPrice": 134.66,
                "bidTick": " ",
                "closePrice": 135.45,
                "netChange": 0.59,
                "totalVolume": 23115635,
                "quoteTimeInLong": 1566950328949,
                "tradeTimeInLong": 1566950275129,
                "mark": 135.87,
                "exchange": "q",
                "exchangeName": "NASD",
                "marginable": true,
                "shortable": true,
                "volatility": 0.0095,
                "digits": 4,
                "52WkHigh": 141.675,
                "52WkLow": 93.96,
                "nAV": 0.0,
                "peRatio": 28.1021,
                "divAmount": 1.84,
                "divYield": 1.36,
                "divDate": "2019-08-14 00:00:00.000",
                "securityStatus": "Normal",
                "regularMarketLastPrice": 135.74,
                "regularMarketLastSize": 2,
                "regularMarketNetChange": 0.29,
                "regularMarketTradeTimeInLong": 1566936001000,
                "netPercentChangeInDouble": 0.4356,
                "markChangeInDouble": 0.42,
                "markPercentChangeInDouble": 0.3101,
                "regularMarketPercentChangeInDouble": 0.2141,
                "delayed": false
              },
              "CVX": {
                "assetType": "EQUITY",
                "symbol": "CVX",
                "description": "Chevron Corporation Common Stock",
                "bidPrice": 116.06,
                "bidSize": 1000,
                "bidId": "P",
                "askPrice": 117.75,
                "askSize": 300,
                "askId": "P",
                "lastPrice": 116.38,
                "lastSize": 0,
                "lastId": "N",
                "openPrice": 116.27,
                "highPrice": 117.03,
                "lowPrice": 115.04,
                "bidTick": " ",
                "closePrice": 115.74,
                "netChange": 0.64,
                "totalVolume": 4238458,
                "quoteTimeInLong": 1566950400019,
                "tradeTimeInLong": 1566949966528,
                "mark": 116.06,
                "exchange": "n",
                "exchangeName": "NYSE",
                "marginable": true,
                "shortable": true,
                "volatility": 0.0147,
                "digits": 2,
                "52WkHigh": 127.6,
                "52WkLow": 100.22,
                "nAV": 0.0,
                "peRatio": 14.94,
                "divAmount": 4.76,
                "divYield": 4.11,
                "divDate": "2019-08-16 00:00:00.000",
                "securityStatus": "Normal",
                "regularMarketLastPrice": 115.83,
                "regularMarketLastSize": 7908,
                "regularMarketNetChange": 0.09,
                "regularMarketTradeTimeInLong": 1566945000008,
                "netPercentChangeInDouble": 0.553,
                "markChangeInDouble": 0.32,
                "markPercentChangeInDouble": 0.2765,
                "regularMarketPercentChangeInDouble": 0.0778,
                "delayed": false
              }
            }
          RESPONSE
        }
      )
    end

    let(:expected_result) do
      {"PG"=>
         {"assetType"=>"EQUITY",
          "symbol"=>"PG",
          "description"=>"Procter & Gamble Company (The) Common Stock",
          "bidPrice"=>120.55,
          "bidSize"=>500,
          "bidId"=>"P",
          "askPrice"=>120.99,
          "askSize"=>500,
          "askId"=>"P",
          "lastPrice"=>120.55,
          "lastSize"=>0,
          "lastId"=>"N",
          "openPrice"=>119.99,
          "highPrice"=>121.05,
          "lowPrice"=>119.78,
          "bidTick"=>" ",
          "closePrice"=>119.32,
          "netChange"=>1.23,
          "totalVolume"=>6996550,
          "quoteTimeInLong"=>1566950400020,
          "tradeTimeInLong"=>1566945034633,
          "mark"=>120.55,
          "exchange"=>"n",
          "exchangeName"=>"NYSE",
          "marginable"=>true,
          "shortable"=>true,
          "volatility"=>0.01,
          "digits"=>2,
          "52WkHigh"=>121.76,
          "52WkLow"=>78.49,
          "nAV"=>0.0,
          "peRatio"=>79.1467,
          "divAmount"=>2.9836,
          "divYield"=>2.5,
          "divDate"=>"2019-07-18 00:00:00.000",
          "securityStatus"=>"Normal",
          "regularMarketLastPrice"=>120.55,
          "regularMarketLastSize"=>12155,
          "regularMarketNetChange"=>1.23,
          "regularMarketTradeTimeInLong"=>1566945000012,
          "netPercentChangeInDouble"=>1.0308,
          "markChangeInDouble"=>1.23,
          "markPercentChangeInDouble"=>1.0308,
          "regularMarketPercentChangeInDouble"=>1.0308,
          "delayed"=>false},
       "MSFT"=>
         {"assetType"=>"EQUITY",
          "symbol"=>"MSFT",
          "description"=>"Microsoft Corporation - Common Stock",
          "bidPrice"=>135.87,
          "bidSize"=>500,
          "bidId"=>"K",
          "askPrice"=>136.06,
          "askSize"=>200,
          "askId"=>"Q",
          "lastPrice"=>136.04,
          "lastSize"=>200,
          "lastId"=>"D",
          "openPrice"=>136.39,
          "highPrice"=>136.72,
          "lowPrice"=>134.66,
          "bidTick"=>" ",
          "closePrice"=>135.45,
          "netChange"=>0.59,
          "totalVolume"=>23115635,
          "quoteTimeInLong"=>1566950328949,
          "tradeTimeInLong"=>1566950275129,
          "mark"=>135.87,
          "exchange"=>"q",
          "exchangeName"=>"NASD",
          "marginable"=>true,
          "shortable"=>true,
          "volatility"=>0.0095,
          "digits"=>4,
          "52WkHigh"=>141.675,
          "52WkLow"=>93.96,
          "nAV"=>0.0,
          "peRatio"=>28.1021,
          "divAmount"=>1.84,
          "divYield"=>1.36,
          "divDate"=>"2019-08-14 00:00:00.000",
          "securityStatus"=>"Normal",
          "regularMarketLastPrice"=>135.74,
          "regularMarketLastSize"=>2,
          "regularMarketNetChange"=>0.29,
          "regularMarketTradeTimeInLong"=>1566936001000,
          "netPercentChangeInDouble"=>0.4356,
          "markChangeInDouble"=>0.42,
          "markPercentChangeInDouble"=>0.3101,
          "regularMarketPercentChangeInDouble"=>0.2141,
          "delayed"=>false},
       "CVX"=>
         {"assetType"=>"EQUITY",
          "symbol"=>"CVX",
          "description"=>"Chevron Corporation Common Stock",
          "bidPrice"=>116.06,
          "bidSize"=>1000,
          "bidId"=>"P",
          "askPrice"=>117.75,
          "askSize"=>300,
          "askId"=>"P",
          "lastPrice"=>116.38,
          "lastSize"=>0,
          "lastId"=>"N",
          "openPrice"=>116.27,
          "highPrice"=>117.03,
          "lowPrice"=>115.04,
          "bidTick"=>" ",
          "closePrice"=>115.74,
          "netChange"=>0.64,
          "totalVolume"=>4238458,
          "quoteTimeInLong"=>1566950400019,
          "tradeTimeInLong"=>1566949966528,
          "mark"=>116.06,
          "exchange"=>"n",
          "exchangeName"=>"NYSE",
          "marginable"=>true,
          "shortable"=>true,
          "volatility"=>0.0147,
          "digits"=>2,
          "52WkHigh"=>127.6,
          "52WkLow"=>100.22,
          "nAV"=>0.0,
          "peRatio"=>14.94,
          "divAmount"=>4.76,
          "divYield"=>4.11,
          "divDate"=>"2019-08-16 00:00:00.000",
          "securityStatus"=>"Normal",
          "regularMarketLastPrice"=>115.83,
          "regularMarketLastSize"=>7908,
          "regularMarketNetChange"=>0.09,
          "regularMarketTradeTimeInLong"=>1566945000008,
          "netPercentChangeInDouble"=>0.553,
          "markChangeInDouble"=>0.32,
          "markPercentChangeInDouble"=>0.2765,
          "regularMarketPercentChangeInDouble"=>0.0778,
          "delayed"=>false}
        }
    end

    it { is_expected.to eql(expected_result) }
  end

  context 'invalid symbol' do
    subject do
      client.get_quotes(symbols)
    end

    let(:symbols) { %w(XZXX) }

    let!(:expected_request) do
      TDAmeritrade::Spec::Mocks::MockGetQuotes.mock_find(
        request: {
          headers: { 'Authorization': "Bearer #{client.access_token}" },
          query: {
            apikey: client.client_id,
            symbol: symbols.join(','),
          }.map {|k,v| [k, v.to_s] }.to_h,
        },
        response: {
          body: <<~RESPONSE
            {}
          RESPONSE
        }
      )
    end

    let(:expected_result) do
      {}
    end

    it { is_expected.to eql(expected_result) }
  end

end