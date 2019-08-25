# TD Ameritrade API gem for Ruby

This is a gem for connecting to the OAuth/JSON-based TD Ameritrade Developers API released in 2018. Go to 
https://developer.tdameritrade.com/ for the official documentation and to create your OAuth application.

For a gem that allows you to connect to the older version of the TDAmeritrade API, go to 
https://github.com/wakproductions/tdameritrade_api

## Installation

In your Gemfile

`gem 'tdameritrade-api-ruby', git: 'https://github.com/wakproductions/tdameritrade-api-ruby.git'`

## Authenticating

Currently this gem is designed for private app authorization. Read this guide for a general overview of signing in your
private app: https://developer.tdameritrade.com/content/simple-auth-local-apps

The TD Ameritrade API now uses OAuth for authentication. For an introduction to the OAuth flow, [I recommend reading
this tutorial](https://www.digitalocean.com/community/tutorials/an-introduction-to-oauth-2).


I plan on writing more detailed instructions in the file /doc/authentication.md

## Basic Usage

```
client = TDAmeritrade::Client.new(
  client_id: 'MYCLIENTID@AMER.OAUTHAP', 
  redirect_uri: 'http://my-redirect-url', 
  refresh_token: 'b6w31RJvP/Cz3MVghpx8S5dzeYVcHygEQHKWYQuI98NGpsMb1j...'
)

client.get_instrument_fundamentals('TWTR')
#=> {"TWTR"=>
      {"fundamental"=>
        {"symbol"=>"TWTR",
         "high52"=>47.79,
         "low52"=>20.12,
         "dividendAmount"=>0.0,
         "dividendYield"=>0.0,
         "peRatio"=>17.93788,
         "pegRatio"=>0.039026,
         "pbRatio"=>3.85707,
         ...
```

# Current State of Functionality

The official API is documented [here](https://developer.tdameritrade.com/apis). This gem currently implements the
following functionality. If you would like to expand its functionality, then please submit a pull request.

[ ] Accounts and Trading
[x] Authentication
[x] Instruments
[ ] Market Hours
[ ] Movers
[ ] Option Chains
[x] Price History
[ ] Quotes
[ ] Transaction History
[ ] User Info and Preferences
[x] Watchlist

## Contributions

If you would like to make a contribution, please submit a pull request to the original branch. Feel free to email me Winston Kotzan
at wak@wakproductions.com with any feature requests, bug reports, or feedback.

#### Wish List

* Test Coverage in RSpec

## Support

Please open an issue on Github if you have any problems or questions.

## Release Notes

See CHANGELOG.md