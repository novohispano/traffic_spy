module TrafficSpy
  class Url < Sequel::Model
    one_to_many :actions
  end
end