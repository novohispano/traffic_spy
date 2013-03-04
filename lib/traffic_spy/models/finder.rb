module TrafficSpy
  module Finder
    def find(search)
      table.where(search).map{|row| self.new(row)}.first
    end

    # def find_or_create(value)
    #   if exits?(value)
    #     find(value.to_sym => value)[:id]
    #   else
    #     register(value)
    #     find(value.to_sym => value)[:id]
    #   end
    # end
  end
end