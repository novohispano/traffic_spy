require 'spec_helper'

module TrafficSpy
  describe TrafficSpy::Action do
    context "class methods" do 
      let (:payload) {{
        "url"=>    "http://chicken.com/blog",
        "requestedAt"=>       "2033-02-16 21:38:28 -0700",
        "respondedIn"=>       37,
        "referredBy"=>        "http://jumpstartlab.com",
        "requestType"=>       "TEST",
        "parameters"=>        [],
        "eventName"=>         "socialLogin",
        "userAgent"=>         "Mozilla/5.0; (Macintosh Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
        "resolutionWidth"=>   "1920",
        "resolutionHeight"=>  "1280",
        "ip"=>                "63.29.38.211"
        }}

      it "should return a hash" do 
        Action.create("jumpstartlab", payload)
        actions = Action.all
        result = Action.response_times(actions)
        expect(result["http://chicken.com/blog"]).to eq 37
      end

      it ".create" do
        identifier = "jumpstartlab"
        Action.create(identifier, payload)
        result = Action.find(:request_type => payload["requestType"]).request_type
        expect(result).to eq "TEST"
      end

      it ".exists?" do
        identifier = "jumpstartlab"
        Action.create(identifier, payload)
        expect(Action.exists?(:requested_at => payload["requestedAt"])).to eq true
      end

    end
  end
end