module ShipActions
  class Fly < Base
    def step
      if arrived?
        false
      else
        @ship.fly_to(@target)
        History.create!(object: @ship, action: :fly_to_target, params: { target: @target })
      end
    end
  end
end
