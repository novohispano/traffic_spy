module TrafficSpy
  class Action #< Sequel::Model
    # many_to_one :sources
    # many_to_one :urls
    # many_to_one :referrers
    # many_to_one :events
    # many_to_one :user_agents
    # many_to_one :resolutions
    # many_to_one :ips

    def self.exists?(identifier, payload)
      DB.from(:actions).where(:created_at => payload["requestedAt"]).to_a.count > 0
    end

    def self.create(identifier, payload)
      return false if missing_parameters?(payload)
      register(identifier, payload)
    end

    def self.missing_parameters?(payload)
      payload = nil
    end

    def self.register(identifier, payload)
      DB.from(:actions).insert(
        :source_id     => Source.find_by_identifier(identifier),
        :url_id        => Url.find_or_create(payload["url"]),
        # :requested_at  => params["requestedAt"],
        # :responded_in  => params["respondedIn"],
        # :referrer_id   => referrers_finder(url),
        # :request_type  => params["requestType"],
        # :event_id      => events_finder(event),
        # :user_agent_id => user_agents_finder(agent),
        # :resolution_id => 
        # :ip_id         => 
        :created_at    => Time.now,
        :updated_at    => Time.now
        )
    end
    #   root = params[:rootUrl]
    #   if identifier == nil || identifier == "" then true
    #   elsif root == nil || root == "" then true
    #   else false
    #   end
    # end

    # def self.sources_finder(identifier)
    #   DB.from(:sources).where(:identifier => identifier).to_a[0][:id]
    # end

    
  end
end