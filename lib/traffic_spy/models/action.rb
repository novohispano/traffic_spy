  module TrafficSpy
  class Action 
    extend Finder
    
    attr_reader :id, 
                :source_id,
                :url_id,
                :requested_at,
                :responded_in,
                :referrer_id,
                :request_type,
                :event_id,
                :user_agent_id,
                :resolution_id,
                :ip_id,
                :created_at,
                :updated_at

    def initialize(params)
      @id            = params[:id]
      @source_id     = params[:source_id]
      @url_id        = params[:url_id]
      @requested_at  = params[:requested_at]
      @responded_in  = params[:responded_in]
      @referrer_id   = params[:referrer_id]
      @request_type  = params[:request_type]
      @event_id      = params[:event_id]
      @user_agent_id = params[:user_agent_id]
      @resolution_id = params[:resolution_id]
      @ip_id         = params[:ip_id]
      @created_at    = params[:created_at]
      @updated_at    = params[:updated_at]
    end

    def self.table
      DB.from(:actions)
    end

    def self.urls(actions)
      urls = Hash.new(0)
      actions.collect do |action| 
        urls[Url.find(id: action.url_id).path] += 1
      end
      urls
    end

    def self.browsers(actions)
      browsers = Hash.new(0)
      actions.collect do |action| 
        browsers[Agent.find(id: action.user_agent_id).browser] += 1
      end
      browsers
    end

    def self.operating_systems(actions)
      os = Hash.new(0)
      actions.collect do |action|
        os[Agent.find(id: action.user_agent_id).operating_system] += 1
      end
      os
    end

    def self.resolutions(actions)
      resolutions = Hash.new(0)
      actions.collect do |action|
        res = Resolution.find(id: action.resolution_id)
        resolutions["#{res.width} x #{res.height}"] += 1
      end
      resolutions
    end

    def self.response_times(actions)
      count = actions.group_by do |action| 
        Url.find(:id => action.url_id).url
      end
      response_hash = Hash.new([])
      count.collect do |url, actions|
        resp = actions.collect do |action|
          action.responded_in
        end
        avg_resp = resp.inject{ |sum, el| sum + el }.to_f / resp.size
        response_hash[url] = avg_resp
      end
      response_hash
    end

    def self.events(actions)
      events = Hash.new(0)
      actions.collect do |action|
        events[Event.find(id: action.event_id).name] += 1
      end
      events
    end
   
    def self.create(identifier, payload)
      table.insert(
        :source_id     => Source.find(:identifier => identifier).id,
        :url_id        => Url.find_or_create("url", payload["url"]),
        :requested_at  => payload["requestedAt"],
        :responded_in  => payload["respondedIn"],
        :referrer_id   => Referrer.find_or_create("url", payload["referredBy"]),
        :request_type  => payload["requestType"],
        :event_id      => Event.find_or_create("name", payload["eventName"]),
        :user_agent_id => Agent.find_or_create(payload["userAgent"]),
        :resolution_id => Resolution.find_or_create(payload["resolutionWidth"], 
                                                    payload["resolutionHeight"]),
        :ip_id         => IP.find_or_create("address", payload["ip"]),
        :created_at    => Time.now,
        :updated_at    => Time.now
        )
    end
  end
end
