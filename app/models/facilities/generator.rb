module Facilities
  class Generator < System
    def step
      bay.ship.generate_power(max_production)
    end
  end
end
