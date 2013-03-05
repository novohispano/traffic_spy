module TrafficSpy
  class Url
    extend Finder

    attr_reader :id,
                :url,
                :created_at,
                :updated_at

    def initialize(params)
      @id         = params[:id]
      @url        = params[:url]
      @created_at = params[:created_at]
      @updated_at = params[:updated_at]
    end

    def self.table
      DB.from(:urls)
    end

    def self.register(url)
      table.insert(
        :url        => url,
        :created_at => Time.now,
        :updated_at => Time.now
        )
    end
  end
end