# require "traffic_spy/version"
require "sinatra"
require "haml"
require "sequel"
require "json"
require "time"
require "./lib/traffic_spy/db/schema"
require "./lib/traffic_spy/models/init"

module TrafficSpy
  get '/' do
    haml :index
  end

  post '/sources' do
    output = Source.process_params(params)
    status output[:code]
    body output[:message]
  end

  post '/sources/:identifier/data' do |identifier|
    output = Action.process_params(identifier, params)
    status output[:code]
    body output[:message]
  end
end