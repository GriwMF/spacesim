module Facilities
  class Generator < System
    def step
      bay.ship.generate(:speed, max_production) if bay.consume(:energy, consumption)
    end
  end
end
