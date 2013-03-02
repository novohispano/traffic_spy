module TrafficSpy
  class IP
    def self.find_or_create(address)
      if IP.exists?(address)
        IP.find_by_url(address)[:id]
      else
        IP.register(address)
        IP.find_by_url(address)[:id]
      end
    end

    def self.exists?(address)
      IP.find_by_url(address).to_a.count > 0
    end

    def self.register(address)
      DB.from(:ips).insert(
        :address => address,
        :created_at => Time.now,
        :updated_at => Time.now
        )
    end

    def self.find_by_url(address)
      DB.from(:ips).where(:address => address).to_a[0]
    end
  end
end