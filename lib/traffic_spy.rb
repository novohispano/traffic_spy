# require "traffic_spy/version"
require "sinatra"
require "haml"
require "sequel"
require "./lib/traffic_spy/db/schema"
require "./lib/traffic_spy/models/init"


module TrafficSpy
  get '/' do
    haml :index
  end
end