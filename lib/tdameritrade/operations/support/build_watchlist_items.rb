module TDAmeritrade; module Operations; module Support
  module BuildWatchlistItems

    # This gem only supports EQUITY type, even though there is a lot more you can do with the API
    def build_watchlist_items(symbol_list)
      symbol_list.map do |symbol|
        {
          "quantity": 0,
          "averagePrice": 0,
          "commission": 0,
          "purchasedDate": (Date.today - 3 * 60 * 60 * 24).strftime('%Y-%m-%d'),
          "instrument": {
            "symbol": symbol,
            "assetType": "EQUITY"
          }
        }
      end
    end

  end
end; end; end