require 'spec_helper'
require 'rack/test'

module TrafficSpy
  describe "controller" do
    context ".process_source and respond" do
      it "returns 200 response with new identifier" do
        output = Controller.process_source({:identifier => "tester", :rootUrl => "http://www.tester.com"})
        expect(output[:code]).to be 200
      end

      it "returns 403 response with duplicate" do
        Controller.process_source({:identifier => "tester", :rootUrl => "http://www.tester.com" })
        output = Controller.process_source({:identifier => "tester", :rootUrl => "http://www.tester.com" })
        expect(output[:code]).to be 403
      end

      it "returns 400 response with bad data" do 
        output = Controller.process_source({:rootUrl => "http://www.tester.com" })
        expect(output[:code]).to be 400
      end
    end

    context ".process_payload and respond" do 
      it "returns 400 response if payload is nil" do 
        identifier = "jumpstartlab"
        params = Hash.new
        params["payload"] = nil
        output = Controller.process_payload(identifier, params)
        expect(output[:code]).to be 400
      end

      it "returns 200 response if payload is recorded" do 
        identifier = "jumpstartlab"
        params = Hash.new
        params["payload"] = Hash.new
        params["payload"] = {
      "url"              => "http://jumpstartlab.com/blog",
      "requestedAt"      => Time.now,
      "respondedIn"      => 37,
      "referredBy"       => "http://jorgedropsdatable.com",
      "requestType"      => "GET",
      "parameters"       => [],
      "eventName"        => "socialLogin",
      "userAgent"        => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
      "resolutionWidth"  => "1920",
      "resolutionHeight" => "1280",
      "ip"               => "63.29.38.211"}.to_json
        output = Controller.process_payload(params,identifier)
        expect(output[:code]).to be 200
      end

    end
  end
end
