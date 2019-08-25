shared_context 'authenticated client' do
  let!(:client) do
    TDAmeritrade::Client.new(
      client_id: 'RUBYAPITEST@AMER.OAUTHAP',
      redirect_uri: 'http://localhost:3000',
      access_token: 'test_access_token',
      refresh_token: 'test_refresh_token'
    )
  end
end