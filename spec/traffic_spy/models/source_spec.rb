require 'spec_helper'

module TrafficSpy
  describe TrafficSpy::Source do
    context "class methods" do
      let (:subject) { described_class }
      
      describe ".create" do
        context "given bad parameters" do
          it "should test if it has missing parameters" do
            params = { :identifier => nil }
            expect(subject.missing_parameters?(params)).to eq true
          end

          it "should not register" do
            params = { :identifier => nil }
            subject.should_not_receive(:create)
          end
        end

        context "when given all the correct parameters" do
          it "should register when it does not exist" do
            params = { :identifier => "jumpstartlab", :rootUrl => "http://jumpstartlab.com"}
            record = subject.create(params)
            expect(record).not_to eq nil
          end

          it "should not register when it already exist" do
            params = { :identifier => "jumpstartlab", :rootUrl => "http://jumpstartlab.com"}
            subject.create(params)
            expect(subject.exists?( :identifier => "jumpstartlab")).to eq true
          end

          it "should register properly" do
            params = { :identifier => "testlab", :rootUrl => "http://testlab.com"}
            subject.register(params)
            instance = subject.find(:identifier => "testlab")
            expect(instance.identifier).to eq "testlab"
            expect(instance.root_url).to eq "http://testlab.com"
          end
        end
      end
    end
  end
end
