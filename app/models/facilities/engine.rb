module Facilities
  class Engine < System
    def step
      bay.ship.generate_speed(max_production) if bay.consume(:power, consumption)
    end
  end
end
