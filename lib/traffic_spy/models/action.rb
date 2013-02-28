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
      payload = JSON.parse(params["payload"])
      if missing_parameters?(payload)
        {:code => 400, :message => "Bad Request! missing required payload"}
      elsif already_exists?(payload)
        {:code => 403, :message => "Identifier already exists!"}
      else
        register(payload)
        {:code => 200, :message => "OK"}
      end
    end

    def self.missing_parameters?(payload)
      true
      #payload == nil || payload == ""
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