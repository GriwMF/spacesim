module Actions
  class Base
    def initialize(character)
      @character = character
    end

    def avaliable_acions
      [:eat, :sleep, :steer]
    end

    def do_action
      case Random.rand(10)
      when (0..5)
        send(avaliable_acions.sample)
      else
        false
      end
    end

    def eat
      # food = %w(капусту суп борщ салат пиццу шаверму бургер)
      sustenance = Random.rand(1..20)

      @character.update!(sustenance: @character.hunger - sustenance)
      History.create!(object: @character, action: :eat, params: { sustenance: sustenance, hunger: @character.hunger })
    end

    # TODO: continuous aciton
    def sleep
      @character.update!(sustenance: @character.fatigue - 5)
      History.create!(object: @character, action: :sleep, params: { fatigue: @character.fatigue })
    end

    def steer
      @character.ship.increment!(:bonus_speed, 5)
      History.create!(object: @character, action: :steer)
    end
  end
end
