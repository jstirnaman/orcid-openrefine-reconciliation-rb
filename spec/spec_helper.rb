require 'webmock/rspec'
# Make sure app can't contact external services during testing.
WebMock.disable_net_connect!(allow_localhost: true)


