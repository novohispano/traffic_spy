module TrafficSpy
  class Source < Sequel::Model
    one_to_many :actions

    def self.process_params(params)
      if missing_parameters?(params)
        {:code => 400, :message => "Bad Request! missing required parameters"}
      elsif already_exists?(params)
        {:code => 403, :message => "Identifier already exists!"}
      else
        register(params)
        {:code => 200, :message => "#{{identifier: @identifier}.to_json}"}
      end
    end
 
    def self.missing_parameters?(params)
      identifier = params[:identifier]
      root = params[:rootUrl]
      if identifier == nil || identifier == "" then true
      elsif root == nil || root == "" then true
      else false
      end
    end

    def self.already_exists?(params)
      DB.from(:sources).where(:identifier => params[:identifier]).to_a.count > 0
    end

    def self.register(params)
      DB.from(:sources).insert(
        :identifier => params[:identifier],
        :root_url => params[:rootUrl],
        :created_at => Time.now
        )
    end
  end
end