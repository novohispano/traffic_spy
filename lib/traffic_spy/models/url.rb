module TrafficSpy
  class Url
    extend Finder

    attr_reader :id,
                :url,
                :host,
                :path,
                :created_at,
                :updated_at

    def initialize(params)
      @id         = params[:id]
      @url        = params[:url]
      @host       = params[:host]
      @path       = params[:path]
      @created_at = params[:created_at]
      @updated_at = params[:updated_at]
    end

    def self.table
      DB.from(:urls)
    end

    def self.register(url)
      table.insert(
        :url        => url,
        :host       => URI(url).host,
        :path       => URI(url).path,
        :created_at => Time.now,
        :updated_at => Time.now
        )
    end
  end
end