module ShipActions
  class Fight < Base
    def self.append_to(ship, **attrs)
      # put ship in fight with random one
      attrs[:enemy] = Ship.where.not(id: ship.id).sample

      super(ship, **attrs)
    end

    def step
      @ship.systems.where(type: 'Facilities::LaserBay').each do |system|
        system.fire(@enemy)
      end

      @enemy.persisted?
    end

    private

  end
end
