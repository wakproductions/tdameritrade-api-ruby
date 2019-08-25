require 'spec_helper'
require 'support/authenticated_client'
require 'tdameritrade'

describe TDAmeritrade::Operations::GetInstrumentFundamentals do
  include_context 'authenticated client'
  # include_context 'webmock off'

  context 'valid symbol' do
    subject do
      client.get_instrument_fundamentals(symbol)
    end

    let(:symbol) { 'PG' }

    let!(:expected_request) do
      TDAmeritrade::Spec::Mocks::MockGetInstrumentFundamentals.mock_find(
        request: {
          headers: { 'Authorization': "Bearer #{client.access_token}" },
          query: {
            apikey: client.client_id,
            symbol: symbol,
            projection: 'fundamental'
          }.map {|k,v| [k, v.to_s] }.to_h,
        },
        response: {
          body: <<~RESPONSE
            {
              "PG": {
                "fundamental": {
                  "symbol": "PG",
                  "high52": 121.76,
                  "low52": 78.49,
                  "dividendAmount": 2.9836,
                  "dividendYield": 2.54,
                  "dividendDate": "2019-07-18 00:00:00.000",
                  "peRatio": 79.14674,
                  "pegRatio": 0.0,
                  "pbRatio": 6.35135,
                  "prRatio": 4.33729,
                  "pcfRatio": 44.97703,
                  "grossMarginTTM": 49.84339,
                  "grossMarginMRQ": 50.80145,
                  "netProfitMarginTTM": 5.85958,
                  "netProfitMarginMRQ": 0.0,
                  "operatingMarginTTM": 8.61208,
                  "operatingMarginMRQ": 0.0,
                  "returnOnEquity": 7.44733,
                  "returnOnAssets": 3.39838,
                  "returnOnInvestment": 4.55386,
                  "quickRatio": 0.58165,
                  "currentRatio": 0.74883,
                  "interestCoverage": 467.625,
                  "totalDebtToCapital": 38.7429,
                  "ltDebtToEquity": 43.21524,
                  "totalDebtToEquity": 63.76234,
                  "epsTTM": 1.48231,
                  "epsChangePercentTTM": 0.0,
                  "epsChangeYear": 0.0,
                  "epsChange": 0.0,
                  "revChangeYear": 0.0,
                  "revChangeTTM": 1.27484,
                  "revChangeIn": 3.83914,
                  "sharesOutstanding": 2502.26,
                  "marketCapFloat": 2499.515,
                  "marketCap": 293565.1,
                  "bookValuePerShare": 0.0,
                  "shortIntToFloat": 0.0,
                  "shortIntDayToCover": 0.0,
                  "divGrowthRate3Year": 0.0,
                  "dividendPayAmount": 0.7459,
                  "dividendPayDate": "2019-11-15 00:00:00.000",
                  "beta": 0.40382,
                  "vol1DayAvg": 6650680.0,
                  "vol10DayAvg": 6548680.0,
                  "vol3MonthAvg": 161420290.0
                },
                "cusip": "742718109",
                "symbol": "PG",
                "description": "Procter & Gamble Company (The) Common Stock",
                "exchange": "NYSE",
                "assetType": "EQUITY"
              }
            }
          RESPONSE
        }
      )
    end

    let(:expected_result) do
      {"PG"=>
         {"fundamental"=>
            {"symbol"=>"PG",
             "high52"=>121.76,
             "low52"=>78.49,
             "dividendAmount"=>2.9836,
             "dividendYield"=>2.54,
             "dividendDate"=>"2019-07-18 00:00:00.000",
             "peRatio"=>79.14674,
             "pegRatio"=>0.0,
             "pbRatio"=>6.35135,
             "prRatio"=>4.33729,
             "pcfRatio"=>44.97703,
             "grossMarginTTM"=>49.84339,
             "grossMarginMRQ"=>50.80145,
             "netProfitMarginTTM"=>5.85958,
             "netProfitMarginMRQ"=>0.0,
             "operatingMarginTTM"=>8.61208,
             "operatingMarginMRQ"=>0.0,
             "returnOnEquity"=>7.44733,
             "returnOnAssets"=>3.39838,
             "returnOnInvestment"=>4.55386,
             "quickRatio"=>0.58165,
             "currentRatio"=>0.74883,
             "interestCoverage"=>467.625,
             "totalDebtToCapital"=>38.7429,
             "ltDebtToEquity"=>43.21524,
             "totalDebtToEquity"=>63.76234,
             "epsTTM"=>1.48231,
             "epsChangePercentTTM"=>0.0,
             "epsChangeYear"=>0.0,
             "epsChange"=>0.0,
             "revChangeYear"=>0.0,
             "revChangeTTM"=>1.27484,
             "revChangeIn"=>3.83914,
             "sharesOutstanding"=>2502.26,
             "marketCapFloat"=>2499.515,
             "marketCap"=>293565.1,
             "bookValuePerShare"=>0.0,
             "shortIntToFloat"=>0.0,
             "shortIntDayToCover"=>0.0,
             "divGrowthRate3Year"=>0.0,
             "dividendPayAmount"=>0.7459,
             "dividendPayDate"=>"2019-11-15 00:00:00.000",
             "beta"=>0.40382,
             "vol1DayAvg"=>6650680.0,
             "vol10DayAvg"=>6548680.0,
             "vol3MonthAvg"=>161420290.0},
          "cusip"=>"742718109",
          "symbol"=>"PG",
          "description"=>"Procter & Gamble Company (The) Common Stock",
          "exchange"=>"NYSE",
          "assetType"=>"EQUITY"}
      }
    end

    it { is_expected.to eql(expected_result) }
  end

  context 'invalid symbol' do
    subject do
      client.get_instrument_fundamentals(invalid_symbol)
    end

    let(:invalid_symbol) { 'XXX' }

    let!(:expected_request) do
      TDAmeritrade::Spec::Mocks::MockGetInstrumentFundamentals.mock_find(
        request: {
          headers: { 'Authorization': "Bearer #{client.access_token}" },
          query: {
            apikey: client.client_id,
            symbol: invalid_symbol,
            projection: 'fundamental'
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