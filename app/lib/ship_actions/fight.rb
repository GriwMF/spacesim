module ShipActions
  class Fight < Base
    def self.append_to(ship, **attrs)
      # put ship in fight with random one
      attrs[:enemy] = Ship.where.not(id: ship.id).sample

      super(ship, **attrs)
    end

    def step(character)
      systems = @ship.systems.where(type: 'Facilities::LaserBay')
      shots = systems.map do |system|
        system.fire(@enemy)
      end

      total_damage = shots.sum { |s| s[:damage] }
      shots_done = shots.tally

      History.create!(object: character, action: :fired, notify: true, params: { damage: total_damage, systems: systems, shots_done: shots_done })
      History.create!(object: @enemy, action: :took_damage, notify: true, params: { damage: total_damage, systems: systems, shots_done: shots_done })

      @enemy.persisted?
    end
  end
end
