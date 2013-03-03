module TrafficSpy
  class UserAgent

    # def self.parse_params(params)
    #   if params
    #     AgentOrange::UserAgent.new(params)
    #   else
    #     AgentOrange::UserAgent.new("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17")
    #   end
    # end

    def self.find_or_create(agent)
      # agent = self.parse_params(params)
      if self.exists?(agent)
        self.find_agent(agent)[0][:id]
      else
        self.register(agent)
        self.find_agent(agent)[0][:id]
      end
    end

    def self.exists?(agent)
      self.find_agent(agent).count > 0 
    
    end

    def self.register(agent)
      DB.from(:user_agents).insert(
        :agent      => agent,
        :created_at => Time.now,
        :updated_at => Time.now
        )
    end

    def self.find_agent(agent)
      DB.from(:user_agents).where(:agent => agent).to_a
    end
  end
end