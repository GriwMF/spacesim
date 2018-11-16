module Facilities
  class System < ApplicationRecord
    self.abstract_class = true

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
