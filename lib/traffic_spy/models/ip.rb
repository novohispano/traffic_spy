module TrafficSpy
  class IP < Sequel::Model
    one_to_many :actions
  end
end