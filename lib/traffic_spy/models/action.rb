  module TrafficSpy
  class Action 

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
        :requested_at  => payload["requestedAt"],
        :responded_in  => payload["respondedIn"],
        :referrer_id   => Referrer.find_or_create(payload["referredBy"]),
        :request_type  => payload["requestType"],
        :event_id      => Event.find_or_create(payload["eventName"]),
        #:user_agent_id => UserAgent.find_or_create(payload["userAgent"]),
        # :resolution_id =>
        :ip_id         => IP.find_or_create(payload["ip"]),
        :created_at    => Time.now,
        :updated_at    => Time.now
        )
    end
  end
end