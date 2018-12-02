require 'tdameritrade/util'
require 'httparty'

module TDAmeritrade
  module Watchlists

    def create_watchlist(account_id, watchlist_name, symbols)
      body = {
        "name": watchlist_name,
        "watchlistItems": build_watchlist_items(symbols)
      }.to_json
      uri = URI("https://api.tdameritrade.com/v1/accounts/#{account_id}/watchlists")
      request = Net::HTTP::Post.new(
        uri.path,
        'authorization' => "Bearer #{access_token}",
        'content-type' => 'application/json'
      )
      request.body = body

      response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) { |http| http.request(request) }

      if response_success?(response)
        true
      else
        Util.parse_json_response(response.body)
      end
    end

    def get_watchlists(account_id = nil)
      response = if account_id
        HTTParty.get(
          'https://api.tdameritrade.com/v1/accounts/watchlists',
          headers: { 'Authorization': "Bearer #{access_token}" },
        )
      else
        HTTParty.get(
          "https://api.tdameritrade.com/v1/accounts/#{account_id}/watchlists",
          headers: { 'Authorization': "Bearer #{access_token}" },
        )
      end

      Util.parse_json_response(response.body)
    end

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
        Util.parse_json_response(response.body)
      end
    end

    def update_watchlist(account_id, watchlist_id, watchlist_name, symbols_to_add=[])
      symbols_to_add = symbols_to_add.is_a? String ? [symbols_to_add] : symbols_to_add
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
        Util.parse_json_response(response.body)
      end
    end

    private

    # This gem only supports EQUITY type, even though there is a lot more you can do with the API
    def build_watchlist_items(symbol_list)
      symbol_list.map do |symbol|
        {
          "quantity": 0,
          "averagePrice": 0,
          "commission": 0,
          "purchasedDate": Date.today.strftime('%Y-%m-%d'),
          "instrument": {
            "symbol": symbol,
            "assetType": "EQUITY"
          }
        }
      end
    end

    def response_success?(response)
      response.code =~ /^2\d\d/
    end
  end
end