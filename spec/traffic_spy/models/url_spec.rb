require 'spec_helper'

module TrafficSpy
  describe TrafficSpy::Url do 
    it "it should register an Url" do 
      Url.register("http://www.text.com/hello")
      instance = Url.find(:url => "http://www.text.com/hello")
      expect(instance.url).to eq "http://www.text.com/hello"
    end
  end
end