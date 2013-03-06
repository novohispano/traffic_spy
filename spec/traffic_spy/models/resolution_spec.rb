require 'spec_helper'

module TrafficSpy  
  describe TrafficSpy::Resolution do 
    it "should register an resolution" do 
      record = Resolution.register("6000", "9000")
      resolution = Resolution.find(:width => "6000", :height => "9000")
      expect(resolution.width).to eq "6000"
      expect(resolution.height).to eq "9000"
    end

    it "should test it exists" do
      record = Resolution.register("6000", "9000")
      expect(Resolution.exists?("6000", "9000")).to eq true
    end

    it "should find a resolution" do
      record = Resolution.register("6000", "9000")
      expect(Resolution.find(:width => "6000", :height => "9000").nil?).to eq false
    end

    context "testing find or create" do
      it "should create a new record" do
        id = Resolution.find_or_create("6000", "9000")
        expect(id.nil?).to eq false
      end

      it "should not create" do
        record = Resolution.register("6000", "9000")
        id = Resolution.find_or_create("6000", "9000")
        expect(record).to eq id
      end
    end
  end 
end
