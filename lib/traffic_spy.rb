
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
      erb :index
    end

    get '/sources/:identifier/events' do |identifier|
      pass unless Source.exists?(:identifier => identifier)
      @source       = Source.find(:identifier => identifier)
      @actions      = Action.find_all(:source_id => @source.id)
      @events       = Action.events(@actions)
      erb :event_index
    end

    get '/sources/*/events/*' do
      identifier, event_name = params[:splat]
      pass unless Source.exists?(:identifier => identifier)
      pass unless Event.exists?(:name => event_name)
      @event    = Event.find(:name => event_name)
      @actions  = Action.find_all(:event_id => @event.id)
      @events   = Action.hour_by_hour(@actions)
      erb :event_show
    end

    get '/sources/*/events/*' do
      identifier, event_name = params[:splat]
      %{<h1>Sorry, event '#{event_name}' does not exist. Go back to
       <a href='/sources/#{identifier}/events'>#{identifier} events</a></h1>}
    end

    get '/sources/:identifier' do |identifier|
      pass unless Source.exists?(:identifier => identifier)
      @source            = Source.find(:identifier => identifier)
      @actions           = Action.find_all(:source_id => @source.id)
      @urls              = Action.urls(@actions)
      @browsers          = Action.browsers(@actions)
      @operating_systems = Action.operating_systems(@actions)
      @resolutions       = Action.resolutions(@actions)
      @url_response      = Action.response_times(@actions)
      @events            = Action.events(@actions)
      erb :sources_index
    end

    get '/sources/:identifier' do |identifier|
      "#{identifier} does not exist!"
    end

    get '/sources/*/urls/*' do
      identifier, path = params[:splat]
      pass              unless Source.exists?(:identifier => identifier)
      @source           = Source.find(:identifier=> identifier)
      @path             = path.prepend("/")
      pass              unless Url.exists?(:path => @path)
      url_id            = Url.find(:path => @path).id
      @actions          = Action.find_all(:url_id => url_id)
      erb :url_show
    end

    get '/sources/*/urls/*' do
      "URL not Requested, go back to your home"
    end

    post '/sources' do
      if Source.exists?(:identifier => params[:identifier])
        output = {:code    => 403,
                  :message => "Identifier already exists!"}
      elsif Source.create(params)
        output = {:code    => 200,
                  :message => "#{{:identifier => params[:identifier]}.to_json}"}
      else
        output = {:code    => 400,
                  :message => "Bad Request! missing required parameters"}
      end
      status output[:code]
      body output[:message]
    end

    post '/sources/:identifier/data' do |identifier|
      if params["payload"] == nil || params["payload"] == ''
        output = {:code    => 400,
                  :message => "Bad Request! missing payload"}
      else
        json = StringIO.new(params["payload"])
        parser = Yajl::Parser.new
        payload = parser.parse(json)
        if Action.exists?(:requested_at => payload["requestedAt"])
          output = {:code    => 403,
                    :message => "Request payload already received."}
        else Action.create(identifier, payload)
          output = {:code    => 200,
                    :message => "OK"}
        end
      end
      status output[:code]
      body output[:message]
    end
  end
end
