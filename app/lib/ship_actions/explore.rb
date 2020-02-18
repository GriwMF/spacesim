module ShipActions
  class Explore < Base

    def self.append_to(ship, **attrs)
      attrs[:target] = CelestialObject.sample
      #   OpenStruct.new(
      #   position_vector: Vector[rand(100) - 50, rand(100) - 50, rand(100) - 50]
      # )
      attrs[:explored] = 0

      super(ship, attrs)
    end

    def step
      if arrived?
        perform_exploration
      else
        ShipActions::Fly.append_to(@ship, target: @target)
      end
    end

    private

    def perform_exploration
      @explored += 25

      if @explored >= 100
        @ship.add_credits(100)
        false
      end
    end
  end
end
