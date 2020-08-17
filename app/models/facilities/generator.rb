module Facilities
  class Generator < System
    def step
      ship.generate_power(max_production)
    end
  end
end
