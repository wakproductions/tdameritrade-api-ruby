shared_context 'authenticated client' do
  let!(:client) do
    # If you turn off WebMock by including the 'webmock_off' shared context in your tests, you can hit the
    # live API with a real ping. Just be sure to replace these values here with actual connection tokens.
    TDAmeritrade::Client.new(
      client_id: 'RUBYAPITEST@AMER.OAUTHAP',
      redirect_uri: 'http://localhost:3000',
      access_token: 'test_access_token',
      refresh_token: 'test_refresh_token'
    )
  end
end