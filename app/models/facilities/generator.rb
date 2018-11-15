module Facilities
  class Generator < System
    def step
      bay.ship.generate(:energy, max_production)
    end
  end
end
