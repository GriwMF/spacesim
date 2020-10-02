module CharacterActions
  class Base
    def initialize(character)
      @character = character
    end

    def available_actions
      actions = [:eat, :sleep]
      actions += [:move, :work] if @character.base_type == 'Ship'
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

    def move
      system = @character.base.systems.sample
      @character.update!(location: system)
      History.create!(object: @character, action: :move, params: { target: system })
    end

    def work
      if @character.location.type == 'control_room'
        @character.location.ship.action_tables.last&.step
      end
      History.create!(object: @character, action: :work, params: { target: @character.location })
    end
  end
end
