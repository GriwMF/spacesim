module CharacterActions
  class Base
    def initialize(character)
      @character = character
    end

    def available_actions
      actions = [:move, :work, :repair] # if @character.base_type == 'Ship'
      # for first demo lets suggest that alarm is on
      #
      #  TODO: check move to is correct due to hard join request
      if @character.facility_todo.nil? && (@move_to = FacilityTodo.looking_for(@character.role))
        [:move]
      else
        [:work]
      end

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
      system = @move_to || @character.base.systems.sample
      @character.update!(location: system, facility_todo: @move_to)
      History.create!(object: @character, action: :move, notify: true, params: { target: system.type, facility_todo: @move_to&.id })
    end

    def work
      # todo - work based on character's role (for now mechanic and repairing, others should be just present)
      # in the future - add task planning for mechanic
      # move ship step to ship, not captain Facilities::ControlRoom
      #
      case @character.role
      when :mechanic
        repair
      end
      # case @character.location.type
      # when 'Facilities::ControlRoom'
      #   @character.location.ship.action_tables.last&.step(@character)
      #   History.create!(object: @character, action: :control, params: { target: @character.location.ship.action_tables.last})
      # when 'Facilities::Dormitory'
      #   @character.update!(fatigue: [@character.fatigue - 5, 0].max, skip: 5)
      #   History.create!(object: @character, action: :sleep, params: { fatigue: @character.fatigue })
      # when 'Facilities::FoodSynthesizer'
      #   # food = %w(капусту суп борщ салат пиццу шаверму бургер)
      #   sustenance = Random.rand(1..20)
      #   @character.update!(hunger: [@character.hunger - sustenance, 0].max, skip: 2)
      #   History.create!(object: @character, action: :eat, params: { sustenance: sustenance, hunger: @character.hunger })
      # else
      #   History.create!(object: @character, action: :try_to_work, params: { target: @character.location.type, id: @character.location.id })
      # end
    end

    def repair
      if @character.location.integrity < 10 && rand < 0.7
        @character.location.repair
        History.create!(ship: @character.base, object: @character, action: :repair, notify: true, params: { location: @character.location.system_name })
      else
        History.create!(ship: @character.base, object: @character, action: :checked, notify: true,
                        params: { location: @character.location.system_name, integrity: @character.location.integrity })
      end
    end
  end
end
