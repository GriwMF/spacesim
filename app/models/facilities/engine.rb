module Facilities
  class Engine < System
    def step
      ship.generate_speed(max_production) if consume(:power)
    end
  end
end
