module TrafficSpy
  module Finder
    def find(search)
      table.where(search).collect{ |row| self.new(row) }.first
    end

    def exists?(search)
      table.where(search).to_a.count > 0
    end

    # def find_or_create(value)
    #   if exits?(:url => value)
    #     find(:url => value).id
    #   else
    #     register(value)
    #     find(:url => value).id
    #   end
    # end
  end
end