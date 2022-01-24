module ShipActions
  class Trade < Base

    def self.append_to(ship, **attrs)
      attrs = { target: ship.trade_target }

      super(ship, attrs) if attrs[:target]
    end

    def step
      if arrived?
        History.create_notification(@ship, :perform_deal)
        perform_deal
      else
        ShipActions::Fly.append_to(@ship, target: @target.factory)
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
