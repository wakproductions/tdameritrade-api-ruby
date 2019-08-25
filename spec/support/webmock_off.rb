# Include this context if you want to do a live test. Be sure to enter actual connection details in
# authenticated_client.rb so that it authenticates.
shared_context 'webmock off' do
  before do
    WebMock.allow_net_connect!
  end
end