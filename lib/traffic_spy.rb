# require "traffic_spy/version"
require "sinatra"
require "haml"
require "sequel"
require "json"
require "./lib/traffic_spy/db/schema"
require "./lib/traffic_spy/models/init"

module TrafficSpy
  get '/' do
    haml :index
  end

  post '/sources' do
    output = Source.process_params(params)
    if output[:code] == 400
      halt 400, output[:message]
    elsif output[:code] == 403
      halt 403, output[:message]
    else
      output[:message]
    end
  end
end