module Facilities
  class Accumulator < System
    def step
      accumulated = ship.gen_consume_power_upto(max_power - power)
      increment!(:power, accumulated)
      History.create!(object: self, action: :accumulate, params: { accumulated: accumulated })
    end
  end
end
