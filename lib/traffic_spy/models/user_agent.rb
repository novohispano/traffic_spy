module TrafficSpy
  class UserAgent < Sequel::Model
    one_to_many :actions
  end
end