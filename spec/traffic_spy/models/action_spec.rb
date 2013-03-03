require 'spec_helper'

module TrafficSpy
  describe TrafficSpy::Action do
    context "class methods" do 
      let (:payload) {{
        "url"=>               "http://jumpstartlab.com/blog",
        "requestedAt"=>       "2033-02-16 21:38:28 -0700",
        "respondedIn"=>       37,
        "referredBy"=>        "http://jumpstartlab.com",
        "requestType"=>       "GET",
        "parameters"=>        [],
        "eventName"=>         "socialLogin",
        "userAgent"=>         "Mozilla/5.0; (Macintosh Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
        "resolutionWidth"=>   "1920",
        "resolutionHeight"=>  "1280",
        "ip"=>                "63.29.38.211"
        }}

      it ".create" do
        identifier = "blair"
        Action.create(identifier, :payload)
        expect(Action.exists?(:payload)).to eq true
      end

      it ".exists?" do 
        identifier = "blair"
        expect(Action.exists?(:payload)).to eq true
      end

      it ".find_by_payload" do
        expect(Action.exists?(:payload)).to eq true
      end
    end
  end
end