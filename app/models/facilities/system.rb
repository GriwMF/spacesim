module Facilities
  class System < ApplicationRecord
    private_class_method :new

    belongs_to :bay

    def step
      raise 'Not Implemented'
    end

    def work

    end

    def status
      {
        durability: durability,
        max_production: max_production,
        consumption: consumption
      }
    end
  end
end
