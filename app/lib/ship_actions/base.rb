module ShipActions
  class Base
    def self.append_action(ship, **attrs)
      action = new(ship, attrs)

      ActionTable.create!(params: action.dump, action_type: self, ship: ship)
    end

    # attrs = { a: 2, b: 3}
    # => @a = 2; @b = 3
    def initialize(ship, **attrs)
      attrs = attrs.transform_keys { |k| "@#{k}" }

      @attrs = attrs.keys
      attrs.each(&method(:instance_variable_set))

      @ship = ship

      History.create!(object: ship, action: :init, params: { class: self.class, attrs: attrs })
    end

    def dump
      @attrs.each(&method(:instance_variable_get))
    end

    def pick_action(ship)
      ShipActions::Trade.append_action(ship)

      # @ship.action = Random.rand(2)
      # @ship.fly = true
      # @ship.progress = 0
      # if @ship.trade?
      #   @ship.production = @ship.check_stocks || @ship.find_material_to_buy
      #   @ship.target = @ship.production.factory
      # else
      #   @ship.target = CelestialObject.sample
      # end
      #
      # @ship.save!
      # History.create!(object: @ship, action: :set_target, params: { production: @ship.production, target: @ship.target, action: @ship.action })
    end

    def step
      raise 'Not implemented'
    end
  end
end
