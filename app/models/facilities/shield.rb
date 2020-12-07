module Facilities
  class Shield < System
    # temporary reassign to not create new attributes
    alias_attribute :absorption, :max_power # reduced damage %
    alias_attribute :efficiency, :consumption    # % of reduction of reduced dmg

    def step; end

    def reduce_damage(damage)
      max_possible_reduction = damage * absorption / 100
      reduced = ship.consume_power_upto(max_possible_reduction, true)
      damage - reduced
    end
  end
end
