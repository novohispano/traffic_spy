require 'spec_helper'

module TrafficSpy
  describe "traffic_spy" do
    context "parsing the JSON" do 
      params = {
        "url"=>               "http://jorgedropsdatable.com/blog",
        "requestedAt"=>       "2013-02-16 21:38:28 -0700",
        "respondedIn"=>        37,
        "referredBy"=>        "http://jorgedropsdatable.com",
        "requestType"=>       "GET",
        "parameters"=>         [],
        "eventName"=>         "socialLogin",
        "userAgent"=>         "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
        "resolutionWidth"=>   "1920",
        "resolutionHeight"=>  "1280",
        "ip"=>                "63.29.38.211"}.to_json
      json = StringIO.new(params)
      parser = Yajl::Parser.new
      payload = parser.parse(json)

      it "should parse the json" do 
        expect(payload.class).to eq Hash
      end

      it "the payload should contain a URL" do 
        expect(payload["url"]).to eq "http://jorgedropsdatable.com/blog"
      end

      it "should have a requestedAt" do 
        expect(payload["requestedAt"]).to eq "2013-02-16 21:38:28 -0700"
      end

      it "should have a IP address" do 
        expect(payload["ip"]).to eq "63.29.38.211"
      end

      it "should have user agent" do 
        expect(payload["userAgent"]).to eq "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17"
      end

    end
  end
end