module TrafficSpy
  class Campaign < Sequel::Model
    one_to_many :events
  end
end