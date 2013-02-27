# require "traffic_spy/version"
require "sinatra"
require "haml"

module TrafficSpy
  get '/' do
    haml :index
  end

end