module ShipTasks
  class Trade < Processor
    def step
      if target.is_output?
        target.factory_stock.sell_all_to(ship, target.price)
      else
        ship.stocks.find_by(material: target.material).sell_all_to(target.factory, target.price)
      end
    end
  end
end
