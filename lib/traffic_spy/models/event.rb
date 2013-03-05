module TrafficSpy
  class Event
    extend Finder

    attr_reader :id,
                :name,
                :created_at,
                :updated_at

    def initialize(params)
      @id         = params[:id]
      @name       = params[:name]
      @created_at = params[:created_at]
      @updated_at = params[:updated_at]
    end

    def self.table
      DB.from(:events)
    end

    def self.register(name)
      table.insert(
        :name       => name,
        :created_at => Time.now,
        :updated_at => Time.now
        )
    end
  end
end