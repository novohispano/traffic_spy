module TrafficSpy
  class Action < Sequel::Model
    many_to_one :sources
    many_to_one :urls
    many_to_one :referrers
    many_to_one :events
    many_to_one :user_agents
    many_to_one :resolutions
    many_to_one :ips
  end
end