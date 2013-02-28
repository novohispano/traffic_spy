require 'spec_helper'

module TrafficSpy
  
  describe TrafficSpy::Source do
    context "class methods" do
      let (:subject) { described_class }
      
      describe ".create" do
        context "given bad parameters" do
          it "it does not save itself" do
            params = {:identifier => "" }
            subject.should_not_receive(:register)
            expect(subject.create(params)).to be_false
          end
        end

        context "when given all the correct parameters" do
          context "when it does not already exist" do
            params = {:identifier => "jumpstartlab", :rootUrl => "http://jumpstartlab.com"}
            subject.should_receive(:register).with(params).and_return(true)
            expect(subject.create(params)).to be_true
          end
        end
      end

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
        
        params = {:identifier => "wikpeds", :rootUrl => "http:/wereushfdsg.com"}
        result = {:code => 200, :message => "#{{identifier: params[:identifier]}.to_json}"}
        output = subject.process_params(params)
        expect(output).to eq result
      end    
    end
  end
end
