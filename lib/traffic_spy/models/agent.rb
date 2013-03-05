module TrafficSpy
  class Agent
    attr_reader :id,
                :operating_system,
                :browser,
                :created_at,
                :updated_at

    def initialize(params)
      @id               = params[:id]
      @operating_system = params[:operating_system]
      @browser          = params[:browser]
      @created_at       = params[:created_at]
      @updated_at       = params[:updated_at]
    end

    def self.table
      DB.from(:agents)
    end

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
      table.insert(
        :operating_system => agent.platform.to_s,
        :browser          => agent.browser.to_s,
        :created_at       => Time.now,
        :updated_at       => Time.now
        )
    end

    def self.find_agents(agent)
      table.where(:operating_system => agent.platform.to_s,
                  :browser          => agent.browser.to_s).to_a
    end
  end
end