module Facilities
  class Accumulator < System
    def step
      increment!(:power, ship.gen_consume_power_upto(max_power - power))
    end
  end
end
