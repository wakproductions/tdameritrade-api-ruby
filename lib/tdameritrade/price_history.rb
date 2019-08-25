require 'tdameritrade/util'
require 'httparty'

module TDAmeritrade
  module PriceHistory

    FREQUENCY_TYPE=[:minute, :daily, :weekly, :monthly]
    PERIOD_TYPE=[:day, :month, :year, :ytd]

    def get_price_history(
        symbol,
        period_type: :day,
        period: 10,
        frequency_type: :minute,
        frequency: 1,
        end_date: nil, # should be a Date
        start_date: nil, # should be a Date
        need_extended_hours_data: false
      )

      params = {
        apikey: client_id,
        periodType: period_type,
        period: period,
        frequencyType: frequency_type,
        frequency: frequency,
        needExtendedHoursData: need_extended_hours_data
      }
      params.merge!(endDate: end_date) if end_date
      params.merge!(startDate: end_date) if start_date

      response = HTTParty.get(
        "https://api.tdameritrade.com/v1/marketdata/#{symbol}/pricehistory",
        headers: { 'Authorization': "Bearer #{access_token}" },
        query: params,
        debug_output: $stdout
      )

      Util.parse_json_response(response)
    end
  end
end