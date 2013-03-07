module TrafficSpy
  class Controller

    def self.process_source(params)
      if Source.exists?(:identifier => params[:identifier])
        output = {:code => 403,:message => "Identifier already exists!"}
      elsif Source.create(params)
        output = {:code => 200,:message => "#{{:identifier => params[:identifier]}.to_json}"}
      else
        output = {:code => 400, :message => "Bad Request! missing required parameters"}
      end
    end
  end
end
