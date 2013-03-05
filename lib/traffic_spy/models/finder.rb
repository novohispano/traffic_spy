module TrafficSpy
  module Finder
    def find(search)
      table.where(search).collect{ |row| self.new(row) }.first
    end

    def find_all(search)
      table.where(search).collect{ |row| self.new(row) }
    end

    def exists?(search)
      table.where(search).to_a.count > 0
    end

    def find_or_create(attribute, value)
      if exists?(attribute.to_sym => value)
        find(attribute.to_sym => value).id
      else
        register(value)
        find(attribute.to_sym => value).id
      end
    end
  end
end