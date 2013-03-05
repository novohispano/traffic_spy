require 'spec_helper'

module TrafficSpy
  describe TrafficSpy::Event do 
    it "it should register an Event" do 
      Event.register("TestEvent")
      instance = Event.find(:name => "TestEvent")
      expect(instance.name).to eq "TestEvent"
    end
  end
end