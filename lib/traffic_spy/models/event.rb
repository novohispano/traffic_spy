module TrafficSpy
  class Event < Sequel::Model
    one_to_many :actions
  end
end