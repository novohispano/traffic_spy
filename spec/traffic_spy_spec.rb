require 'spec_helper'
require 'rack/test'

module TrafficSpy
  describe "traffic_spy" do
    include Rack::Test::Methods

    def app
      TrafficSpy::AppServer
    end

    params = {
      "url"              => "http://jorgedropsdatable.com/blog",
      "requestedAt"      => "2013-02-16 21:38:28 -0700",
      "respondedIn"      => 37,
      "referredBy"       => "http://jorgedropsdatable.com",
      "requestType"      => "GET",
      "parameters"       => [],
      "eventName"        => "socialLogin",
      "userAgent"        => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
      "resolutionWidth"  => "1920",
      "resolutionHeight" => "1280",
      "ip"               => "63.29.38.211"}.to_json

    json = StringIO.new(params)
    parser = Yajl::Parser.new
    payload = parser.parse(json)

    context "parsing the JSON" do 
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

    context "router/controller" do
      it "shows the homepage" do
        get '/'
        last_response.should be_ok
      end

      it "shows events page" do
        get '/sources/jumpstartlab/events'
        last_response.should be_ok
      end

      it "shows event page" do
        get '/sources/jumpstartlab/events/socialLogin'
        expect(last_response).to be_ok
      end

      it "shows identifier page" do
        get '/sources/jumpstartlab'
        expect(last_response).to be_ok
      end

      it "shows a path page" do
        get '/sources/jumpstartlab/urls/blog'
        expect(last_response).to be_ok
      end
    end

    context "when posting a source" do
      it "posts a source" do
        post '/sources', { :identifier => "tester", :rootUrl => "http://www.tester.com" }
        expect(last_response.status).to be 200
      end

      it "doesn't post a source" do
        2.times { post '/sources', { :identifier => "tester", :rootUrl => "http://www.tester.com" } }
        expect(last_response.status).to be 403
      end

      it "doesn't post a source when missing parameters" do
        post '/sources'
        expect(last_response.status).to be 400
      end
    end

    context "when creating an action" do
      it "detects a missing param" do
        post '/sources/jumpstartlab/data'
        expect(last_response.status).to be 400
      end

      it "detects params already exist" do
        2.times { post '/sources/jumpstartlab/data', { :payload => params } }
        expect(last_response.status).to be 403
      end
    end
  end
end