# require "traffic_spy/version"
require "sinatra"
require "erb"
require "sequel"
require "yajl/json_gem"
require "time"
require "useragent"
require "debugger"

require "./lib/traffic_spy/db/schema"
require "./lib/traffic_spy/models/init"

module TrafficSpy
  class AppServer < Sinatra::Base

    get '/' do
      @sources = Source.all
      erb :index, :layout => :main_layout
    end

    get '/sources/:identifier' do |identifier|
      @source = {:identifier => identifier, :root_url => Source.find(:identifier => identifier).root_url}
      @actions = Action.find_all_by_identifier(identifier)
      @urls = Action.urls(@actions)
      erb :sources_data, :layout => :main_layout
    end

    get '/sources/*/urls/*' do 
      @params = params
      erb :urls, :layout => :main_layout
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
      if params["payload"] == nil || params["payload"] == ''
        output = {:code => 400, :message => "Bad Request! missing payload"}
      else
        json = StringIO.new(params["payload"])
        parser = Yajl::Parser.new
        payload = parser.parse(json)
        if Action.exists?(payload)
          output = {:code => 403, :message => "Request payload already received."}
        else Action.create(identifier, payload)
          output = {:code => 200, :message => "OK"}
        end
      end
      status output[:code]
      body output[:message]
    end

  end
end
