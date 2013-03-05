module TrafficSpy
  class IP
    extend Finder

    attr_reader :id,
                :address,
                :created_at,
                :updated_at

    def initialize(params)
      @id         = params[:id]
      @address    = params[:address]
      @created_at = params[:created_at]
      @updated_at = params[:updated_at]
    end

    def self.table
      DB.from(:ips)
    end

    def self.register(address)
      table.insert(
        :address    => address,
        :created_at => Time.now,
        :updated_at => Time.now
        )
    end
  end
end