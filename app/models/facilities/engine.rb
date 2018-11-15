module Facilities
  class Generator < System
    def step
      bay.ship.generate(:speed, max_production) if bay.ship.consume(:energy, consumption)
    end
  end
end
