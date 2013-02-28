module TrafficSpy
  class Action < Sequel::Model
    many_to_one :sources
    many_to_one :urls
    many_to_one :referrers
    many_to_one :events
    many_to_one :user_agents
    many_to_one :resolutions
    many_to_one :ips

    def self.process_params(identifier, params)
      if missing_parameters?(params)
        {:code => 400, :message => "Bad Request! missing required payload"}
      elsif already_exists?(params)
        {:code => 403, :message => "Identifier already exists!"}
      else
        register(params)
        {:code => 200, :message => "OK"}
      end
    end

    def self.missing_parameters?(params)
      params["payload"] == nil #|| params["payload"] == "" #ask Frank
    end

    def self.already_exists?(params)
      #DB.from(:actions).where(:identifier => params[:identifier]).to_a.count > 0
      false
    end

    def self.register(params)

      # DB.from(:actions).insert(
      #   :identifier => params[:identifier],
      #   :root_url => params[:rootUrl],
      #   :created_at => Time.now
      #   )
    end
  end
end