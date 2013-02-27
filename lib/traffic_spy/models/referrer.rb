module TrafficSpy
  class Referrer < Sequel::Model
    one_to_many :actions
  end
end