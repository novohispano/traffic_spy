module TrafficSpy
  class Resolution < Sequel::Model
    one_to_many :actions
  end
end