module TrafficSpy
  class Controller

    def self.process_payload(params, identifier)
      if params["payload"] == nil || params["payload"] == ''
        output = {:code    => 400,
                  :message => "Bad Request! missing payload"}
      else
        json = StringIO.new(params["payload"])
        parser = Yajl::Parser.new
        payload = parser.parse(json)
        if Action.exists?(:requested_at => payload["requestedAt"])
          output = {:code    => 403,
                    :message => "Request payload already received."}
        else Action.create(identifier, payload)
          output = {:code    => 200,
                    :message => "OK"}
        end
      end
    end

    def self.process_source(params)
      if Source.exists?(:identifier => params[:identifier])
        output = {:code => 403,:message => "Identifier already exists!"}
      elsif Source.create(params)
        output = {:code => 200,
                  :message => "#{{:identifier => params[:identifier]}.to_json}"}
      else
        output = {:code => 400,
                  :message => "Bad Request! missing required parameters"}
      end
    end

  end
end
