require 'spec_helper'

module TrafficSpy
  describe TrafficSpy::IP do 
    it "should register an IP" do
      IP.register("123.456.789.100")
      instance = IP.find(:address => "123.456.789.100")
      expect(instance.address).to eq "123.456.789.100"
    end
  end
end