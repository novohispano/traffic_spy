Bundler.require
require './lib/traffic_spy'

app = TrafficSpy::AppServer
run app
