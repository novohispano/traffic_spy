# require "traffic_spy/version"
require "sinatra"
require "erb"
require "sequel"
require "json"
require "time"
require "agent_orange"
require "debugger"
require "./lib/traffic_spy/db/schema"
require "./lib/traffic_spy/models/init"

module TrafficSpy
  
  get '/' do
    erb :index
  end

  get '/sources/:identifier/data' do
    erb :sources_data
  end

  post '/sources' do
    if Source.exists?(params)
      output = {:code => 403, :message => "Identifier already exists!"}
    elsif Source.create(params)
      output = {:code => 200, :message => "#{{:identifier => params[:identifier]}.to_json}"}
    else
      output = {:code => 400, :message => "Bad Request! missing required parameters"}
    end
    status output[:code]
    body output[:message]
  end

  post '/sources/:identifier/data' do |identifier|
    payload = JSON.parse(params["payload"].gsub(/;/, ""))
    if Action.exists?(identifier, payload)
      output = {:code => 403, :message => "Request payload already received."}
    elsif Action.create(identifier, payload)
      output = {:code => 200, :message => "OK"}
    else
      output = {:code => 400, :message => "Bad Request! missing payload"}
    end
    status output[:code]
    body output[:message]
  end
end