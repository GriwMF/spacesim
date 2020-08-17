module Facilities
  # PARAMS:
  # - shot_damage
  # - shield absorption
  # - armour absorption
  # - systems girth
  # - scatter
  # - shot_range?
  class LaserBay < System
    def fire(target)
      if consume(:power)
    end
  end
end
