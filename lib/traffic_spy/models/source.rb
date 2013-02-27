module TrafficSpy
  class Source < Sequel::Model
    one_to_many :actions
  end
end