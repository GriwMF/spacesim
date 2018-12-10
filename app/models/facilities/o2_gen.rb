module Facilities
  class O2Gen < System
    def step
      bay.ship.generate(:o2, max_production) if bay.consume(:energy, consumption)
    end
  end
end
