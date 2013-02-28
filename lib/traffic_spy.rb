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
    extract_params(params,:identifier,:rootUrl)
    output = Action.process_params(identifier, params)
    status output[:code]
    body output[:message]
  end
end