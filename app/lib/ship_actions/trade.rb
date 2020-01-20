module ShipActions
  class Trade < Base

    def self.append_action(ship, **attrs)
      attrs = { target: ship.check_stocks || ship.find_material_to_buy }

      super(ship, attrs)
    end

    def step
      if arrived?
        perform_deal
      else
        ShipActions::Fly.append_action(@ship, target: @target.factory)
      end
    end

    private

    def perform_deal
      if @target.is_output?
        @target.factory_stock.sell_all_to(@ship, @target.price)
      else
        @ship.stocks.find_by(material: @target.material).sell_all_to(@target.factory, @target.price)
      end

      false
    end

    def arrived?
      @ship.distance_to(@target.factory) <= WorldDatum::ARRIVED_DISTANCE
    end
  end
end
