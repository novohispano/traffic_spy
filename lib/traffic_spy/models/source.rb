module TrafficSpy
  class Source
    extend Finder

    attr_reader :id,
                :identifier,
                :root_url,
                :created_at,
                :updated_at

    def initialize(params)
      @id         = params[:id]
      @identifier = params[:identifier]
      @root_url   = params[:root_url]
      @created_at = params[:created_at]
      @updated_at = params[:updated_at]
    end

    def self.table
      DB.from(:sources)
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
      table.insert(
        :identifier => params[:identifier],
        :root_url   => params[:rootUrl],
        :created_at => Time.now,
        :updated_at => Time.now
        )
    end
  end
end
