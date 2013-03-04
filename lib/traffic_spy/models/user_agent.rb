module TrafficSpy
  class Agent
    def self.parse_params(params)
      UserAgent.parse(params)
    end

    def self.find_or_create(params)
      agent = self.parse_params(params)
      if self.exists?(agent)
        self.find_agents(agent)[0][:id]
      else
        self.register(agent)
        self.find_agents(agent)[0][:id]
      end
    end

    def self.exists?(agent)
      true if self.find_agents(agent).count > 0 
    end

    def self.register(agent)
      DB.from(:user_agents).insert(
        :operating_system => agent.platform.to_s,
        :browser          => agent.browser.to_s,
        :created_at       => Time.now,
        :updated_at       => Time.now
        )
    end

    def self.find_agents(agent)
      DB.from(:user_agents).where(:operating_system => agent.platform.to_s,
                                  :browser => agent.browser.to_s).to_a
    end
  end
end