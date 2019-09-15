require 'tdameritrade/operations/base_operation'

module TDAmeritrade; module Operations
  class GetPriceHistory < BaseOperation

    # Not used right now, but can be used later on for validation
    FREQUENCY_TYPE=[:minute, :daily, :weekly, :monthly]
    PERIOD_TYPE=[:day, :month, :year, :ytd]

    def call(
      symbol,
      period_type: nil,
      period: nil,
      frequency_type: :minute,
      frequency: 1,
      end_date: nil, # should be a Date
      start_date: nil, # should be a Date
      need_extended_hours_data: false
    )
      params = {
        apikey: client.client_id,
        frequencyType: frequency_type,
        frequency: frequency,
        needExtendedHoursData: need_extended_hours_data,
      }

      # NOTE: can't use period if using start and end dates
      params.merge!(periodType: period_type) if period_type
      params.merge!(period: period) if period
      params.merge!(startDate: "#{start_date.strftime('%s')}000") if start_date
      params.merge!(endDate: "#{end_date.strftime('%s')}000") if end_date

      response = perform_api_get_request(
        url: "https://api.tdameritrade.com/v1/marketdata/#{symbol}/pricehistory",
        query: params,
      )

      parsed_response = parse_api_response(response)

      if parsed_response["candles"]
        parsed_response["candles"].map do |candle|
          if candle["datetime"].is_a? Numeric
            candle["datetime"] = Time.at(candle["datetime"] / 1000)
          end
        end
      end

      parsed_response
    end

    private

  end
end; end