module CharacterActions
  class Base
    def initialize(character)
      @character = character
    end

    def available_actions
      actions = [:move, :work] # if @character.base_type == 'Ship'
    end

    def do
      case Random.rand(10)
      when (0..5)
        send(available_actions.sample)
      else
        History.create!(object: @character, action: :idle)
      end
    end

    def move
      system = @character.base.systems.sample
      @character.update!(location: system)
      History.create!(object: @character, action: :move, params: { target: system.type })
    end

    def work
      case @character.location.type
      when 'Facilities::ControlRoom'
        @character.location.ship.action_tables.last&.step(@character)
        History.create!(object: @character, action: :control, params: { target: @character.location.ship.action_tables.last})
      when 'Facilities::Dormitory'
        @character.update!(fatigue: [@character.fatigue - 5, 0].max, skip: 5)
        History.create!(object: @character, action: :sleep, params: { fatigue: @character.fatigue })
      when 'Facilities::FoodSynthesizer'
        # food = %w(капусту суп борщ салат пиццу шаверму бургер)
        sustenance = Random.rand(1..20)
        @character.update!(hunger: [@character.hunger - sustenance, 0].max, skip: 2)
        History.create!(object: @character, action: :eat, params: { sustenance: sustenance, hunger: @character.hunger })
      else
        History.create!(object: @character, action: :try_to_work, params: { target: @character.location.type, id: @character.location.id })
      end
    end
  end
end
