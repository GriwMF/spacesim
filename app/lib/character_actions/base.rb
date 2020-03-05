module CharacterActions
  class Base
    def initialize(character)
      @character = character
    end

    def available_actions
      actions = [:eat, :sleep]
      actions += [:check_bay, :work, :steer] if @character.base_type == 'Ship'
      actions
    end

    def do
      case Random.rand(10)
      when (0..5)
        send(available_actions.sample)
      else
        History.create!(object: @character, action: :idle)
      end
    end

    def eat
      # food = %w(капусту суп борщ салат пиццу шаверму бургер)
      sustenance = Random.rand(1..20)

      @character.update!(hunger: @character.hunger - sustenance, skip: 5)
      History.create!(object: @character, action: :eat, params: { sustenance: sustenance, hunger: @character.hunger })
    end

    def sleep
      @character.update!(fatigue: @character.fatigue - 5, skip: 5)
      History.create!(object: @character, action: :sleep, params: { fatigue: @character.fatigue })
    end

    def steer
      @character.base.increment!(:bonus_speed, 5)
      @character.update!(skip: 2, location: @character.base.control_bay)
      History.create!(object: @character, action: :steer)
    end

    def check_bay
      bay = @character.base.bays.sample
      @character.update!(location: bay)
      bay.increment!(:integrity) if bay.integrity < 100
      History.create!(object: @character, action: :check_bay, params: { status: bay.status, target: bay })
    end

    def work
      bay = @character.base.bays.sample
      @character.update!(location: bay)
      system = bay.systems.sample
      system&.work
      History.create!(object: @character, action: :work, params: { bay: bay, system: system })
    end
  end
end
