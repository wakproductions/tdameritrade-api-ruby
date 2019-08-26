require 'tdameritrade/operations/base_operation'

module TDAmeritrade; module Operations
  class GetWatchlists < BaseOperation

    def call(account_id: )
      response = perform_api_get_request(url: "https://api.tdameritrade.com/v1/accounts/#{account_id}/watchlists")
      parse_api_response(response)
    end

  end
end; end