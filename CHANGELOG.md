Version 1.3.0.20210215
- Added tracking of token expiration dates to instance vars
- API request results are now returned as a Hashie::Mash to make 'quotes' or :symbol reference of values indifferent
- Corrected incorrect date submission in create watchlist operation

Verion 1.2.0.20190915
- (Breaking change) Make get_price_history return datetime stamp as Ruby Time vs milliseconds since epoch  

Verion 1.1.1.20190915
- Fix incorrect formatting when using startdate and enddate in get_price_history 

Version 1.1.0 8/28/19
- Enhance error messages for rate limit and invalid token

Version 1.0 8/27/19
- Change structure internally to use dependency injection of oprations
- Price history feature
- Real time quotes feature
- Added RSpec test coverage

Version 0.2.alpha 
- Basic Watchlist retrieval and modification

Version 0.1.alpha - 11/29/2018
- Initial, very basic release
- Authentication: refresh access token by refresh_token
- Instruments: get fundamentals


