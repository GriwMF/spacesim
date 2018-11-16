module Actions
  class Base
    def initialize(character)
      @character = character
    end

    def avaliable_acions
      [:eat, :sleep, :steer, :check_bay, :work]
    end

    def do_action
      case Random.rand(10)
      when (0..5)
        send(avaliable_acions.sample)
      else
        History.create!(object: @character, action: :idle)
      end
    end

    def eat
      # food = %w(капусту суп борщ салат пиццу шаверму бургер)
      sustenance = Random.rand(1..20)

      @character.decrement!(:hunger, sustenance)
      History.create!(object: @character, action: :eat, params: { sustenance: sustenance, hunger: @character.hunger })
    end

    # TODO: continuous aciton
    def sleep
      @character.decrement!(:fatigue, 5)
      History.create!(object: @character, action: :sleep, params: { fatigue: @character.fatigue })
    end

    def steer
      @character.ship.increment!(:bonus_speed, 5)
      History.create!(object: @character, action: :steer)
    end

    def check_bay
      bay = @character.ship.bays.sample
      History.create!(object: @character, target: bay, action: :check_bay, params: bay.status)
    end

    def work
      system = @character.ship.bays.sample.systems.sample
      system.work
      History.create!(object: @character, target: system, action: :work)
    end
  end
end
