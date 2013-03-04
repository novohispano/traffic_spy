module TrafficSpy
  class Url
    extend Finder
    attr_reader :id, :url

    def initialize(params)
      @id = params[:id]
      @url = params[:url]
    end

    def self.table
      DB.from(:urls)
    end

    def self.find_or_create(url)
      if exists?(:url => url)
        find(:url => url).id
      else
        register(url)
        find(:url => url).id
      end
    end


    def self.register(url)
      table.insert(
        :url => url, 
        :created_at => Time.now,
        :updated_at => Time.now
        )
    end
  end
end
