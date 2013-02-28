module TrafficSpy
  class Source < Sequel::Model
    one_to_many :actions

    def self.process_params(params)
      @identifier = params[:identifier]
      @rooturl = params[:rootUrl]
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
      if identifier == nil || identifier == ""
        true
      elsif root == nil || root == ""
        true
      else
        false
      end
    end

    def self.register(params)
      identifier = params[:identifier]
      root = params[:rootUrl]
      DB.from(:sources).insert(
        :identifier => identifier,
        :root_url => root
        )
    end

    def self.already_exists?(params)
      DB.from(:sources).where(:identifier => params[:identifier]).to_a.count > 0
    end
  end
end