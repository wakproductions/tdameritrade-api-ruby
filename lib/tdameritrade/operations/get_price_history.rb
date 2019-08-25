require 'httparty'
require 'tdameritrade/error'
require 'tdameritrade/util'
require 'tdameritrade/operations/base_operation'

module TDAmeritrade; module Operations
  class GetPriceHistory < BaseOperation
    include Util

    # Not used right now, but can be used later on for validation
    FREQUENCY_TYPE=[:minute, :daily, :weekly, :monthly]
    PERIOD_TYPE=[:day, :month, :year, :ytd]

    def call(
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
        apikey: client.client_id,
        periodType: period_type,
        period: period,
        frequencyType: frequency_type,
        frequency: frequency,
        needExtendedHoursData: need_extended_hours_data,
      }
      params.merge!(endDate: end_date) if end_date
      params.merge!(startDate: end_date) if start_date

      response = perform_api_get_request(
        url: "https://api.tdameritrade.com/v1/marketdata/#{symbol}/pricehistory",
        query: params,
      )

      parse_api_response(response)
    end

  end
end; end