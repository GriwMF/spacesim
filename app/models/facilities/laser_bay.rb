module Facilities
  # PARAMS:
  # - shot_damage
  # - shield absorption
  # - armour absorption
  # - max systems girth
  # - scatter
  # - shot_range?
  class LaserBay < System
    def step
      # recharge, aiming, etc
    end

    def fire(target)
      if consume(:power)
        shot_damage = 20

        armor_absorption = 0.8 # should be calc based on ship armor
        max_systems_girth = 2
        scatter = 0.25

        scatter_amount = Random.rand(scatter * 2) - scatter

        armor_damage = shot_damage * armor_absorption
        armor_damage += armor_damage * scatter_amount

        damage_left = [shot_damage - armor_damage, 0].max

        target.take_damage(armor_damage)

        return if target.destroyed?

        systems = target.systems.sample(max_systems_girth)

        loop do
          break if systems.one? || damage_left.zero?

          system_damage = damage_left / systems.size
          system_damage += system_damage * scatter_amount
          damage_left = [damage_left - system_damage, 0].max
          systems.pop.take_damage(system_damage)
        end

        systems.pop.take_damage(damage_left)
      end
    end
  end
end
