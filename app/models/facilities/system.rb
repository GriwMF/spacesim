module Facilities
  class System < ApplicationRecord
    private_class_method :new

    belongs_to :ship
    has_many :characters, as: :location

    # uncomment to use ordered systems steps
    # default_scope { order(:priority) }

    def consume(resource, consumption = self.consumption)
      History.create!(object: self, action: :consume, params: {
          type: type,
          ship_id: ship.id,
          resource: resource, amount: consumption, result: send(resource) >= consumption })
      return ship.consume_power(consumption) if resource == :power

      decrement!(resource, consumption) if send(resource) >= consumption
    end

    def consume_upto(amount, resource = :power)
      consumed = [amount, power].min
      decrement!(resource, consumed)
      consumed
    end

    def take_damage(damage)
      History.create!(object: self, action: :damage, params: {
          type: type,
          ship_id: ship.id,
          integrity: integrity, damage: damage })
      if integrity > damage
        decrement!(:integrity, damage)
      else
        History.create!(object: self, action: :system_destroy, params: {          type: type,
                                                                                  ship_id: ship.id})
        destroy!
      end
    end

    def fire(target)
      raise 'Not a weapon (shot is not implemented)' unless respond_to?(:shot, true)

      name = self.class.to_s.split('::').last
      damage = shot(target)
      { name: name, damage: damage }
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
