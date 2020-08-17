module Facilities
  class O2Gen < System
    def step
      ship.generate_oxygen(max_production) if consume(:power)
    end
  end
end
