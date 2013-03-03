  module TrafficSpy
  class Action 

    def self.exists?(payload)
      true if Action.find_by_payload(payload).count > 0 
    end

    def self.find_by_payload(payload)
      DB.from(:actions).where(:requested_at => payload["requestedAt"]).to_a
    end

    def self.create(identifier, payload)
      DB.from(:actions).insert(
        :source_id     => Source.find_by_identifier(identifier),
        :url_id        => Url.find_or_create(payload["url"]),
        :requested_at  => payload["requestedAt"],
        :responded_in  => payload["respondedIn"],
        :referrer_id   => Referrer.find_or_create(payload["referredBy"]),
        :request_type  => payload["requestType"],
        :event_id      => Event.find_or_create(payload["eventName"]),
        :user_agent_id => UserAgent.find_or_create(payload["userAgent"]),
        :resolution_id => Resolution.find_or_create(payload["resolutionWidth"], 
                                                    payload["resolutionHeight"]),
        :ip_id         => IP.find_or_create(payload["ip"]),
        :created_at    => Time.now,
        :updated_at    => Time.now
        )
    end
  end
end