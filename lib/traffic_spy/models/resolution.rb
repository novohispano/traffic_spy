module TrafficSpy
  class Resolution
    def self.find_or_create(width, height)
      if Resolution.exists?(width, height)
        Resolution.find_by_resolution(width, height)[:id]
      else
        Resolution.register(width, height)
        Resolution.find_by_resolution(width, height)[:id]
      end
    end

    def self.exists?(width, height)
      Resolution.find_by_resolution(width, height).to_a.count > 0
    end

    def self.register(width, height)
      DB.from(:resolutions).insert(
        :width => width,
        :height => height,
        :created_at => Time.now,
        :updated_at => Time.now
        )
    end

    def self.find_by_resolution(width, height)
      DB.from(:resolutions).where(:width => width, :height => height).to_a[0]
    end
  end
end