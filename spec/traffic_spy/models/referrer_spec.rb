require 'spec_helper'

module TrafficSpy
  describe TrafficSpy::Referrer do 
    it "it should register a referrer" do 
      Referrer.register("http://test.com")
      instance = Referrer.find(:url => "http://test.com")
      expect(instance.url).to eq "http://test.com"
    end
  end
end