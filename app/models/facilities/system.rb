module Facilities
  class System < ApplicationRecord
    private_class_method :new

    belongs_to :ship
    has_many :characters, as: :location

    def consume(resource)
      History.create!(object: self, action: :consume, params: { resource: resource, amount: consumption, result: send(resource) >= consumption })
      decrement!(resource, consumption) if send(resource) >= consumption
    end

    def take_damage(damage)
      History.create!(object: self, action: :damage, params: { integrity: integrity, damage: damage })
      if integrity > damage
        decrement!(integrity, damage)
      else
        History.create!(object: self, action: :system_destroy)
        destroy!
      end
    end

    def step
      raise 'Not Implemented'
    end

    def work
    end

    def status
      {
        integrity: integrity,
        max_production: max_production,
        consumption: consumption
      }
    end
  end
end
