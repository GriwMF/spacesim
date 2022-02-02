module ShipActions
  class Base
    def self.append_to(ship, attrs = {})
      action = new(ship, attrs)

      ActionTable.create!(params: action.dump, action_type: self, ship: ship)

      History.create!(object: ship, action: :append_action, notify: true, params: { action_type: self.to_s })
    end

    # attrs = { a: 2, b: 3 }
    # => @a = 2; @b = 3
    def initialize(ship, attrs = {})
      attrs = attrs.transform_keys { |k| "@#{k}" }

      @attrs = attrs.keys
      attrs.each { |k, v| instance_variable_set(k, v) }

      @ship = ship

      History.create!(object: ship, action: :init, params: { class: self.class.to_s, attrs: attrs })
    end

    def dump
      @attrs.inject({}) do |hash, key|
        hash[key[1..-1]] = instance_variable_get(key)
        hash
      end
    end

    def step
      raise 'Not implemented'
    end

    private

    def arrived?
      @ship.distance_to(@target) <= WorldDatum::ARRIVED_DISTANCE
    end
  end
end
