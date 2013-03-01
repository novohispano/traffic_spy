module TrafficSpy
  class Url
    def self.find_or_create(url)
      if Url.exists?(url)
        Url.find_by_url(url)[:id]
      else
        Url.register(url)
        Url.find_by_url(url)[:id]
      end
    end

    def self.exists?(url)
      Url.find_by_url(url).to_a.count > 0
    end

    def self.register(url)
      DB.from(:urls).insert(
        :url => url, 
        :created_at => Time.now
        )
    end

    def self.find_by_url(url)
      DB.from(:urls).where(:url => url).to_a[0]
    end
  end
end