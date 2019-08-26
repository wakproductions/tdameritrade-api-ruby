require 'tdameritrade/util'
require 'tdameritrade/util_response'
require 'httparty'

module TDAmeritrade
  module Watchlists
    include UtilResponse

    def replace_watchlist(account_id, watchlist_id, watchlist_name, new_symbols=[])
      body = {
        "name": watchlist_name,
        "watchlistId": watchlist_id,
        "watchlistItems": build_watchlist_items(new_symbols)
      }.to_json

      uri = URI("https://api.tdameritrade.com/v1/accounts/#{account_id}/watchlists/#{watchlist_id}")
      request = Net::HTTP::Patch.new(
        uri.path,
        'authorization' => "Bearer #{access_token}",
        'content-type' => 'application/json'
      )
      request.body = body
      response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) { |http| http.request(request) }

      if response_success?(response)
        true
      else
        Util.parse_json_response(response)
      end
    end

    def update_watchlist(account_id, watchlist_id, watchlist_name, symbols_to_add=[])
      symbols_to_add = symbols_to_add.is_a?(String) ? [symbols_to_add] : symbols_to_add
      body = {
        "name": watchlist_name,
        "watchlistId": watchlist_id,
        "watchlistItems": build_watchlist_items(symbols_to_add)
      }.to_json

      uri = URI("https://api.tdameritrade.com/v1/accounts/#{account_id}/watchlists/#{watchlist_id}")
      request = Net::HTTP::Patch.new(
        uri.path,
        'authorization' => "Bearer #{access_token}",
        'content-type' => 'application/json'
      )
      request.body = body
      response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) { |http| http.request(request) }

      if response_success?(response)
        true
      else
        Util.parse_json_response(response)
      end
    end

    private

  end
end