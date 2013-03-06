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
      actions.each_with_object(Hash.new(0)) do |action, urls|
        urls[Url.find(id: action.url_id).path] += 1
      end
    end

    def self.browsers(actions)
      actions.each_with_object(Hash.new(0)) do |action, browsers|
        browsers[Agent.find(id: action.user_agent_id).browser] += 1
      end
    end

    def self.operating_systems(actions)
      actions.each_with_object(Hash.new(0)) do |action, os|
        os[Agent.find(id: action.user_agent_id).operating_system] += 1
      end
    end

    def self.resolutions(actions)
      actions.each_with_object(Hash.new(0)) do |action, resolutions|
        res = Resolution.find(id: action.resolution_id)
        resolutions["#{res.width} x #{res.height}"] += 1
      end
    end

    def self.response_times(actions)
      response_hash = Hash.new([])
      group_actions(actions).collect do |url, actions|
        resp = actions.collect do |action|
          action.responded_in
        end
        avg_resp = resp.inject{ |sum, el| sum + el }.to_f / resp.size
        response_hash[url] = avg_resp
      end
      response_hash
    end

    def self.group_actions(actions)
      actions.group_by{ |action| Url.find(:id => action.url_id).url }
    end

    def self.events(actions)
      actions.each_with_object(Hash.new(0)) do |action, events|
        events[Event.find(id: action.event_id).name] += 1
      end
    end

    def self.hour_by_hour(actions)
      actions.each_with_object(Hash.new(0)) do |action, events|
        events[action.created_at.hour] += 1
      end
    end

    def self.create(identifier, load)
      table.insert(
        :source_id     => Source.find(:identifier => identifier).id,
        :url_id        => Url.find_or_create("url", load["url"]),
        :requested_at  => load["requestedAt"],
        :responded_in  => load["respondedIn"],
        :referrer_id   => Referrer.find_or_create("url", load["referredBy"]),
        :request_type  => load["requestType"],
        :event_id      => Event.find_or_create("name", load["eventName"]),
        :user_agent_id => Agent.find_or_create(load["userAgent"]),
        :resolution_id => Resolution.find_or_create(load["resolutionWidth"],
                                                    load["resolutionHeight"]),
        :ip_id         => IP.find_or_create("address", load["ip"]),
        :created_at    => Time.now,
        :updated_at    => Time.now
        )
    end
  end
end
