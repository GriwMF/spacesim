module ShipActions
  class Fly < Base
    def step(character)
      if arrived?
        History.create!(object: @ship, action: :arrived, params: { target: @target })
        false
      else
        @ship.fly_to(@target)
        History.create!(object: @ship, action: :fly_to_target, params: { target: @target })
      end
    end
  end
end
