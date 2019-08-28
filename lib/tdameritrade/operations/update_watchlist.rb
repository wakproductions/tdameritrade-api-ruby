require 'tdameritrade/operations/base_operation'
require 'tdameritrade/operations/support/build_watchlist_items'

module TDAmeritrade; module Operations
  class UpdateWatchlist < BaseOperation
    include Support::BuildWatchlistItems

    def call(account_id, watchlist_id, watchlist_name, symbols_to_add=[])
      symbols_to_add = symbols_to_add.is_a?(String) ? [symbols_to_add] : symbols_to_add
      body = {
        "name": watchlist_name,
        "watchlistId": watchlist_id,
        "watchlistItems": build_watchlist_items(symbols_to_add)
      }.to_json

      uri = URI("https://api.tdameritrade.com/v1/accounts/#{account_id}/watchlists/#{watchlist_id}")
      request = Net::HTTP::Patch.new(
        uri.path,
        'authorization' => "Bearer #{client.access_token}",
        'content-type' => 'application/json'
      )
      request.body = body
      response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) { |http| http.request(request) }

      if response_success?(response)
        true
      else
        parse_api_response(response)
      end
    end

  end
end; end