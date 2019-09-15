require 'tdameritrade/util'
require 'hashie'
require 'httparty'

module TDAmeritrade
  module Authentication
    attr_reader :client_id, :redirect_uri, :authorization_code, :access_token, :refresh_token,
                :access_token_expires_at, :refresh_token_expires_at

    # This is the OAuth code retrieved from your browser window, first step in OAuth needed to retrieve the tokens
    def get_access_tokens(authorization_grant_code)
      # headers = { 'Content-Type': 'application/x-www-form-urlencoded' } # turns out didn't need this
      params = {
        'grant_type': 'authorization_code',
        'access_type': 'offline',
        'code': authorization_grant_code,
        'client_id': client_id,
        'redirect_uri': redirect_uri
      }
      response = HTTParty.post(
        'https://api.tdameritrade.com/v1/oauth2/token',
        body: params
      )

      if response.status == 200
        @access_token = response["access_token"]
        @refresh_token = response["refresh_token"]
      end

      response
    end

    def get_new_access_token
      params = {
        grant_type: 'refresh_token',
        refresh_token: refresh_token,
        access_type: 'offline',
        client_id: client_id,
        redirect_uri: redirect_uri
      }

      response = HTTParty.post(
        'https://api.tdameritrade.com/v1/oauth2/token',
        body: params
      )

      update_tokens(
        Hashie.symbolize_keys(
          Util.parse_json_response(response)
        )
      )
    end
    alias :refresh_access_token :get_new_access_token

    def update_tokens(args={})
      gem_error(args[:error]) if args.has_key?(:error)

      @access_token = args[:access_token]
      @refresh_token = args[:refresh_token]
      @access_token_expires_at = Time.now + (args[:expires_in] || 0)
      @refresh_token_expires_at = Time.now + (args[:refresh_token_expires_in] || 0)

      args
    end
  end
end