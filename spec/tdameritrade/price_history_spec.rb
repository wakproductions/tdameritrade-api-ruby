require 'spec_helper'
require 'support/authenticated_client'
require 'tdameritrade'

describe TDAmeritrade::PriceHistory do
  include_context 'authenticated client'
  # include_context 'webmock off'

  let(:single_ticker) { 'PG' }
  let(:multiple_tickers) { ['PG', 'MSFT', 'BA'] }

  context '5 days of 5-min candles' do
    context 'single ticker' do
      subject { client.get_price_history(single_ticker, period_type: :day, frequency: 5, frequency_type: :minute) }

      let!(:expected_request) do
        TDAmeritrade::Spec::Mocks::MockGetPriceHistory.mock_find(
          symbol: single_ticker,
          request: {
            headers: { 'Authorization': "Bearer #{client.access_token}" },
            query: {
              apikey: client.client_id,
              periodType: 'day',
              period: 10,
              frequencyType: 'minute',
              frequency: 5,
              needExtendedHoursData: 'false'
            }.map {|k,v| [k, v.to_s] }.to_h,
          },
          response: {
            body: <<~RESPONSE
              {
                "candles": [
                  {
                    "open": 119.44,
                    "high": 119.54,
                    "low": 119.44,
                    "close": 119.54,
                    "volume": 208,
                    "datetime": 1566558000000
                  },
                  {
                    "open": 119.54,
                    "high": 119.54,
                    "low": 119.54,
                    "close": 119.54,
                    "volume": 104,
                    "datetime": 1566559800000
                  }
                ],
                "symbol": "PG",
                "empty": false
              }
            RESPONSE
          }
        )
      end

      let(:expected_result) do
        {
          "candles"=>
           [{"open"=>119.44, "high"=>119.54, "low"=>119.44, "close"=>119.54, "volume"=>208, "datetime"=>1566558000000},
            {"open"=>119.54, "high"=>119.54, "low"=>119.54, "close"=>119.54, "volume"=>104, "datetime"=>1566559800000}],
          "symbol"=>"PG",
          "empty"=>false
        }
      end

      it { is_expected.to eql(expected_result) }
    end

    context 'multiple tickers' do

    end

    context 'invalid period type' do

    end

    context 'mismatched frequency type and interval' do

    end
  end









  it "should populate certain instance variables after logging in" do

  end
  #
  # it "should retrieve the last 2 days of 30 min data" do
  #   result = client.get_price_history(ticker_symbol, intervaltype: :minute, intervalduration: 30, periodtype: :day, period: 2).first[:bars]
  #   expect(result).to be_a Array
  #   expect(result.length).to eq(26) # 13 half hour periods in a trading day (not including extended hours) times 2
  #   validate_price_bar(result.first)
  # end
  #
  # it "should retrieve a date range of data" do
  #   result = client.get_price_history(ticker_symbol, intervaltype: :daily, intervalduration: 1, startdate: Date.new(2014,7,22), enddate: Date.new(2014,7,25)).first[:bars]
  #   expect(result).to be_a Array
  #   expect(result.length).to eq(4)
  #   validate_price_bar(result.first)
  # end
  #
  # it "should be able to get recent daily price history using get_daily_price_history" do
  #   result = client.get_daily_price_history ticker_symbol, '20140707', '20140707'
  #   #=> [{:open=>14.88, :high=>15.58, :low=>14.65, :close=>14.85, :volume=>36713.1, :timestamp=>2014-07-07 00:00:00 -0400, :interval=>:day}]
  #
  #   expect(result).to be_a Array
  #   expect(result.length).to eq(1)
  #   validate_price_bar(result.first)
  # end
  #
  # it "should be able to get the recent price history for multiple symbols at a time" do
  #   result = client.get_price_history(ticker_symbols, intervaltype: :daily, intervalduration: 1, startdate: Date.new(2015,2,2), enddate: Date.new(2015,2,12))
  #   #=> [
  #   # {:symbol=>'SNDK', :bars=>[{:open=>..., :high=>..., ..., ...},{:open=>...}]},
  #   # {:symbol=>'WDC', :bars=>...},
  #   # {:symbol=>'MU', :bars=>...}
  #   # ]
  #
  #   expect(result).to be_a Array
  #   expect(result.length).to eq(3)
  #
  #   first_result = result[0]
  #   expect(first_result).to have_key :symbol
  #   expect(first_result).to have_key :bars
  #   validate_price_bar(first_result[:bars].first)
  # end
  #
  # it "should not be able to get any data unless logged in" do
  #
  # end
  #
  # it "should be able to download the daily data for a stock" do
  #
  # end
  #
  # it "should be able to download the minute history data for a stock" do
  #
  # end
  #
  # private
  # def validate_price_bar(price_bar)
  #   expect(price_bar[:open]).to be_a_kind_of Numeric
  #   expect(price_bar[:high]).to be_a_kind_of Numeric
  #   expect(price_bar[:low]).to be_a_kind_of Numeric
  #   expect(price_bar[:close]).to be_a_kind_of Numeric
  #   expect(price_bar[:volume]).to be_a_kind_of Numeric
  #   expect(price_bar[:timestamp]).to be_a_kind_of Time
  # end

end