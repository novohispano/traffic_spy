module TrafficSpy
  class Resolution
    extend Finder
    
    attr_reader :id,
                :width,
                :height,
                :created_at,
                :updated_at

    def initialize(params)
      @id         = params[:id]
      @width      = params[:width]
      @height     = params[:height]
      @created_at = params[:created_at]
      @updated_at = params[:updated_at]
    end

    def self.table
      DB.from(:resolutions)
    end

    def self.find_or_create(width, height)
      if self.exists?(width, height)
        self.find_by_resolution(width, height)[:id]
      else
        self.register(width, height)
        self.find_by_resolution(width, height)[:id]
      end
    end

    def self.exists?(width, height)
      self.find_by_resolution(width, height).to_a.count > 0
    end

    def self.register(width, height)
      table.insert(
        :width      => width,
        :height     => height,
        :created_at => Time.now,
        :updated_at => Time.now
        )
    end

    def self.find_by_resolution(width, height)
      table.where(:width  => width.to_s, 
                  :height => height.to_s).to_a[0]
    end
  end
end
