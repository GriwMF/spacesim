module ShipActions
  class Fly < Base
    def step
      if arrived?
        false
      else
        speed = @ship.calculate_speed
        @ship.move_towards(@target, speed)
        @ship.save!
        History.create!(object: @ship, action: :fly_to_target, params: { speed: speed, target: @target })
      end
    end

    private

    def arrived?
      @ship.distance_to(@target) <= WorldDatum::ARRIVED_DISTANCE
    end
  end
end
