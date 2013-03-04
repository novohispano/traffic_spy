require 'spec_helper'

module TrafficSpy
  describe TrafficSpy::Agent do     
    it "should pull the OS and Browser from the string" do 
      agent = Agent.find_or_create("Mozilla/5.0 (Macintosh Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17")
      expect(agent).to eq 2
    end
  end
end