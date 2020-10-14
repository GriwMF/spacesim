module ShipActions
  class Fight < Base
    def self.append_to(ship, **attrs)
      # put ship in fight with random one
      attrs[:enemy] = Ship.where.not(id: ship.id).sample

      super(ship, **attrs)
    end

    def step(character)
      systems = @ship.systems.where(type: 'Facilities::LaserBay')
      total_damage = systems.sum do |system|
        system.fire(@enemy)
      end

      History.create!(object: character, action: :fired, params: { damage: total_damage, systems: systems })

      @enemy.persisted?
    end
  end
end
