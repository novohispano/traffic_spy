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

    # context ".process_payload and respond" do 
      
    # end
  end
end
