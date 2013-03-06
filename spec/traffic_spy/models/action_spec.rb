require 'spec_helper'

module TrafficSpy
  describe TrafficSpy::Action do
    let (:payload) {{
      "url"=>    "http://chicken.com/coocoo",
      "requestedAt"=>       "2033-02-16 21:38:28 -0700",
      "respondedIn"=>       1000,
      "referredBy"=>        "http://jumpstartlab.com",
      "requestType"=>       "TEST",
      "parameters"=>        [],
      "eventName"=>         "socialLogin",
      "userAgent"=>         "Mozilla/5.0; (Testintosh Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Testrome/24.0.1309.0 Testafari/537.17",
      "resolutionWidth"=>   "6000",
      "resolutionHeight"=>  "9000",
      "ip"=>                "123.123.123.123"
      }}

    it "should return a all response times associated to this action" do 
      Action.create("jumpstartlab", payload)
      actions = Action.all
      result = Action.response_times(actions)
      expect(result["http://chicken.com/coocoo"]).to eq 1000
    end

    it "should create an action" do
      identifier = "jumpstartlab"
      Action.create(identifier, payload)
      result = Action.find(:request_type => payload["requestType"]).request_type
      expect(result).to eq "TEST"
    end

    it "should test it exists" do
      identifier = "jumpstartlab"
      Action.create(identifier, payload)
      expect(Action.exists?(:requested_at => payload["requestedAt"])).to eq true
    end

    it "should test it does not exists" do
      expect(Action.exists?(:requested_at => payload["requestedAt"])).to eq false
    end

    it "should return the urls associated with this action" do
      Action.create("jumpstartlab", payload)
      actions = Action.all
      result = Action.urls(actions)
      expect(result["/coocoo"]).to eq 1
    end

    it "should return all the browsers associated with this action" do
      Action.create("jumpstartlab", payload)
      actions = Action.all
      result = Action.browsers(actions)
      expect(result["Safari"]).to eq 1
    end

    it "should return all the operating_systems associated with this action" do
      Action.create("jumpstartlab", payload)
      actions = Action.all
      result = Action.operating_systems(actions)
      expect(result["Testintosh Intel Mac OS X 10_8_2"]).to eq 1
    end

    it "should return all the resolutions associated with this action" do
      Action.create("jumpstartlab", payload)
      actions = Action.all
      result = Action.resolutions(actions)
      expect(result["6000 x 9000"]).to eq 1
    end

    it "should return all the events associated with this action" do
      Action.create("jumpstartlab", payload)
      actions = Action.all
      result = Action.events(actions)
      expect(result["socialLogin"]).to eq 1
    end

    it "should return a hash of event data grouped by hour." do 
      Action.create("jumpstartlab", payload)
      
    end
  end
end
