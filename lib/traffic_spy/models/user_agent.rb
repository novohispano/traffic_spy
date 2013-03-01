module TrafficSpy
  class UserAgent
    attr_reader :agent_object

    def self.parse_params(params)
      @agent_object = AgentOrange::UserAgent.new(params)
    end

    def self.find_or_create(params)
      self.parse_params(params)
      if self.exists?(@agent_object)
        self.find_agent(user_agent)[:id]
      else
        self.register(user_agent)
        self.find_agent(user_agent)[:id]
      end
    end

    def self.exists?(user_agent)
      self.find_agent(user_agent).to_a.count > 0
    end

    def self.register(user_agent)
      DB.from(:user_agents).insert(
        :platform         => user_agent.device.platform,
        :operating_system => user_agent.device.operating_system,
        :engine_browser   => user_agent.device.engine.browser,
        :engine           => user_agent.device.engine,
        :created_at       => Time.now
        )
    end

    def self.find_agent(user_agent)
      DB.from(:user_agents).where(
        :platform         => user_agent.device.platform,
        :operating_system => user_agent.device.operating_system,
        :engine_browser   => user_agent.device.engine.browser,
        :engine           => user_agent.device.engine
        )
    end
  end
end