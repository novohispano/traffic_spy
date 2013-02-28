require 'spec_helper'

module TrafficSpy
  
  describe TrafficSpy::Source do
    context "class methods" do
      let (:subject) { described_class }
      
      it ".process_params" do 
        pending "currently copying the same test as 'already exists'. we need to figure out a better way to test."
        
        params = {:identifier => "jumpstartlab", :rootUrl => "http://jumpstartlab.com"}
        result = {:code=>403, :message=>"Identifier already exists!"}
        output = subject.process_params(params)
        expect(output).to eq result
      end

      it ".missing_parameters" do
        params = {:rootUrl => "http://jumpstartlab.com"}
        result = {:code => 400, :message => "Bad Request! missing required parameters"}
        output = subject.process_params(params)
        expect(output).to eq result
      end

      it ".already_exists?" do
        params = {:identifier => "jumpstartlab", :rootUrl => "http://jumpstartlab.com"}
        result = {:code=>403, :message=>"Identifier already exists!"}
        output = subject.process_params(params)
        expect(output).to eq result
      end

      it ".register" do 
        pending "check how to stub database entry? we are currently creating a real record in the DB"
        
        params = {:identifier => "facebook", :rootUrl => "http://facebook.com"}
        result = {:code => 200, :message => "#{{identifier: params[:identifier]}.to_json}"}
        output = subject.process_params(params)
        expect(output).to eq result
      end    
    end
  end
end
