require 'spec_helper'

module TrafficSpy
  describe TrafficSpy::Source do
    context "class methods" do
      let (:subject) { described_class }
      
      describe ".create" do
        
        context "given bad parameters" do
          it "it does not save itself" do
            params = {:identifier => nil }
            subject.should_receive(:missing_parameters?).and_return(true)
            subject.create(params)
          end
        end

        context "given bad parameters" do
          it "it does not save itself" do
            params = {:identifier => nil }
            subject.should_not_receive(:register)
            subject.create(params)
          end
        end

        context "when given all the correct parameters" do
          it "when it does not already exist" do
            params = {:identifier => "jumpstartlab", :rootUrl => "http://jumpstartlab.com"}
            subject.should_receive(:register).with(params).and_return(true)
            subject.create(params)
          end
        end

        context "when given all the correct parameters" do
          it "when it already exist" do
            params = {:identifier => "jumpstartlab", :rootUrl => "http://jumpstartlab.com"}
            subject.exists?(params)
            subject.should_not_receive(:register)
          end
        end
      end
    end
  end
end
