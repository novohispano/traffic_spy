require 'spec_helper'

module TrafficSpy
  describe TrafficSpy::Action do
    context "class methods" do 
      let (:payload) {{
        "url"=>               "http://jumpstartlab.com/blog",
        "requestedAt"=>       "2013-02-16 21:38:28 -0700",
        "respondedIn"=>        37,
        "referredBy"=>        "http://jumpstartlab.com",
        "requestType"=>       "GET",
        "parameters"=>         [],
        "eventName"=>         "socialLogin",
        "userAgent"=>         "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
        "resolutionWidth"=>   "1920",
        "resolutionHeight"=>  "1280",
        "ip"=>                "63.29.38.211"
        }}

      it ".exists?" do 
        identifier = "jumpstartlab"
        expect(Action.exists?(identifier,:payload)).to eq true
      end

      it ".create returns false with nil payload" do 
        identifier = "jumpstartlab"
        payload = nil
        expect(Action.create(identifier, payload)).to eq false
      end

      it ".create" do
        identifier = "jumpstartlab"
        Action.create(identifier, :payload)
        expect(Action.exists?(identifier, :payload)).to eq true
      end

      it ".missing_parameters?" do 
        payload = nil
        expect(Action.missing_parameters?(payload)).to eq true
      end
    end
  end
end