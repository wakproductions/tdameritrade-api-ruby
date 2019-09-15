require 'spec_helper'
require 'support/authenticated_client'
require 'tdameritrade'

describe TDAmeritrade::Operations::GetPriceHistory do
  include_context 'authenticated client'
  # include_context 'webmock off'

  let(:single_ticker) { 'PG' }
  let(:multiple_tickers) { ['PG', 'MSFT', 'BA'] }

  context '5 days of 5-min candles' do
    context 'single ticker' do
      subject do
        client.get_price_history(single_ticker, period_type: :day, period: 10, frequency: 5, frequency_type: :minute)
      end

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
           [{"open"=>119.44, "high"=>119.54, "low"=>119.44, "close"=>119.54, "volume"=>208, "datetime"=>Time.at(1566558000000 / 1000)},
            {"open"=>119.54, "high"=>119.54, "low"=>119.54, "close"=>119.54, "volume"=>104, "datetime"=>Time.at(1566559800000 / 1000)}],
          "symbol"=>"PG",
          "empty"=>false
        }
      end

      it { is_expected.to eql(expected_result) }
    end

    context 'multiple tickers' do
      pending 'does not appear to be supported yet by the API'
    end

    context 'invalid ticker or one with no data' do
      subject do
        client.get_price_history(invalid_ticker, period: 1, period_type: :month, frequency: 5, frequency_type: :minute)
      end
      let(:invalid_ticker) { 'XXX' }

      let!(:expected_request) do
        TDAmeritrade::Spec::Mocks::MockGetPriceHistory.mock_find(
          symbol: invalid_ticker,
          request: {
            headers: { 'Authorization': "Bearer #{client.access_token}" },
            query: {
              apikey: client.client_id,
              periodType: 'month',
              period: 1,
              frequencyType: 'minute',
              frequency: 5,
              needExtendedHoursData: 'false'
            }.map {|k,v| [k, v.to_s] }.to_h,
          },
          response: {
            body: <<~RESPONSE
              {"candles":[],"symbol":"XXX","empty":true}
            RESPONSE
          }
        )
      end

      let(:expected_result) do
        {
          "candles"=> [],
          "symbol"=>"XXX",
          "empty"=>true
        }
      end

      it { is_expected.to eql(expected_result) }
    end

    context 'invalid request due to mismatched frequency type and interval' do
      subject do
        # Can't use minute with the monthly period type
        client.get_price_history(
          single_ticker,
          period_type: :month,
          period: 10,
          frequency: 5,
          frequency_type: :minute,
          need_extended_hours_data: true
        )
      end

      let!(:expected_request) do
        TDAmeritrade::Spec::Mocks::MockGetPriceHistory.mock_find(
          symbol: single_ticker,
          request: {
            headers: { 'Authorization': "Bearer #{client.access_token}" },
            query: {
              apikey: client.client_id,
              periodType: 'month',
              period: 10,
              frequencyType: 'minute',
              frequency: 5,
              needExtendedHoursData: 'true'
            }.map {|k,v| [k, v.to_s] }.to_h,
          },
          response: {
            status: 400,
            body: <<~RESPONSE
              {"error":"Bad request."}
            RESPONSE
          }
        )
      end

      it 'raises an error' do
        expect { subject }.to raise_error(TDAmeritrade::Error::TDAmeritradeError, "400: Bad request.")
      end
    end

  end

end