module ShipActions
  class Fight < Base
    def self.append_to(ship, **attrs)
      # put ship in fight with random one
      # attrs[:enemy] = Ship.where.not(id: ship.id).sample
      # no need - it's setted in seeds
      # in real life shuold be set in control room

      super(ship, **attrs)
    end

    def step
      return make_preparations unless @initialized

      systems = @ship.systems.where(type: 'Facilities::LaserBay')
      shots = systems.map do |system|
        system.fire(@enemy)
      end

      total_damage = shots.sum { |s| s[:damage] }
      shots_done = shots.tally

      History.create!(object: @ship, action: :fired, notify: true, params: { damage: total_damage, systems: systems, shots_done: shots_done })
      History.create!(object: @enemy, action: :took_damage, notify: true, params: { damage: total_damage, systems: systems, shots_done: shots_done })

      @enemy.persisted?
    end

    private

    def make_preparations
      @ship.systems.where(type: 'Facilities::LaserBay').each do |system|
        system.facility_todos.where(role: :gunner).first_or_create
      end

      @ship.systems.where(type: 'Facilities::ControlBay').each do |system|
        system.facility_todos.where(role: :captain).first_or_create
        system.facility_todos.where(role: :pilot).first_or_create
      end

      @ship.systems.where(type: 'Facilities::Engine').each do |system|
        system.facility_todos.where(role: :mechanic).first_or_create
      end

      @initialized = true
    end
  end
end
