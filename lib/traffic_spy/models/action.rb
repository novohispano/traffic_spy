  module TrafficSpy
  class Action 
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

    def self.all
      table.select.collect{|row| Action.new(row)}  
    end

    def self.urls(actions)
      urls = Hash.new(0)
      actions.map{|action| urls[Url.find(id: action.url_id).url] += 1}
      urls.sort_by {|k,v| -v}
    end

    def self.find_all_by_identifier(identifier)
      id = Source.find_by_identifier(identifier)
      DB.from(:actions).where(:source_id => id).map{|row| Action.new(row)}
    end
    
    def self.exists?(payload)
      true if Action.find_by_payload(payload).count > 0 
    end

    def self.find_by_payload(payload)
      DB.from(:actions).where(:requested_at => payload["requestedAt"]).to_a
    end

    def self.create(identifier, payload)
      DB.from(:actions).insert(
        :source_id     => Source.find_by_identifier(identifier),
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
