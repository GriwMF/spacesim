module Facilities
  class O2Gen < System
    def step
      bay.ship.generate_oxygen(max_production) if bay.consume(:power, consumption)
    end
  end
end
