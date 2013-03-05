require 'spec_helper'

module TrafficSpy
  describe TrafficSpy::Agent do     
    it "should register an agent" do 
      agent = Agent.parse_params("Mozilla/5.0 (Macintosh Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17")
      record = Agent.register(agent)
      expect(agent.browser).to eq "Chrome"
    end

    it "should test it exists" do
      agent = Agent.parse_params("Mozilla/5.0 (Macintosh Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17")
      record = Agent.register(agent)
      expect(Agent.exists?(agent)).to eq true
    end

    it "should find an agent" do
      agent = Agent.parse_params("Mozilla/5.0 (Macintosh Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17")
      record = Agent.register(agent)
      expect(Agent.find_agents(agent).count).to eq 1
    end

    it "should get created" do
      agent = Agent.parse_params("Mozilla/5.0 (Macintosh Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17")
      record = Agent.register(agent)
      instance = Agent.find(:id => record)
      expect(instance.operating_system).to eq "Macintosh Intel Mac OS X 10_8_2"
      expect(instance.browser).to eq "Chrome"
    end

    context "testing find or create" do
      it "should create a new record" do
        id = Agent.find_or_create("Mozilla/5.0 (Macintosh Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17")
        expect(id.nil?).to eq false
      end

      it "should not create" do
        agent = Agent.parse_params("Mozilla/5.0 (Macintosh Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17")
        record = Agent.register(agent)
        id = Agent.find_or_create("Mozilla/5.0 (Macintosh Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17")
        expect(record).to eq id
      end
    end
  end
end