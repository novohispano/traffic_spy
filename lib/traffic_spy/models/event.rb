module TrafficSpy
  class Event
    def self.find_or_create(name)
      if Event.exists?(name)
        Event.find_by_url(name)[:id]
      else
        Event.register(name)
        Event.find_by_url(name)[:id]
      end
    end

    def self.exists?(name)
      Event.find_by_url(name).to_a.count > 0
    end

    def self.register(name)
      DB.from(:events).insert(
        :name => name, 
        :created_at => Time.now,
        :updated_at => Time.now
        )
    end

    def self.find_by_url(name)
      DB.from(:events).where(:name => name).to_a[0]
    end
  end
end