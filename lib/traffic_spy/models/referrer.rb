module TrafficSpy
  class Referrer
    def self.find_or_create(url)
      if Referrer.exists?(url)
        Referrer.find_by_url(url)[:id]
      else
        Referrer.register(url)
        Referrer.find_by_url(url)[:id]
      end
    end

    def self.exists?(url)
      Referrer.find_by_url(url).to_a.count > 0
    end

    def self.register(url)
      DB.from(:referrers).insert(
        :url => url, 
        :created_at => Time.now,
        :updated_at => Time.now
        )
    end

    def self.find_by_url(url)
      DB.from(:referrers).where(:url => url).to_a[0]
    end
  end
end