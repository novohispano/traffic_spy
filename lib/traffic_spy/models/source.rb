module TrafficSpy
  class Source
    def initialize(source)
      @id = source[:id]
      @identifier = source[:identifier]
      @root_url = source[:root_url]
    end

    def self.find_by_identifier(identifier)
      DB.from(:sources).where(:identifier => identifier).to_a[0][:id]
    end

    def self.exists?(params)
      DB.from(:sources).where(:identifier => params[:identifier]).to_a.count > 0
    end

    def self.create(params)
      return false if missing_parameters?(params)
      register(params)
    end

    def self.missing_parameters?(params)
      identifier = params[:identifier]
      root = params[:rootUrl]
      if identifier == nil || identifier == "" then true
      elsif root == nil || root == "" then true
      else false
      end
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