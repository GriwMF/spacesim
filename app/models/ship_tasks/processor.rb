module ShipTasks
  class Processor < ApplicationRecord
    private_class_method :new

    belongs_to :ship

    def step
      raise 'Not Implemented'
    end

    def select_action

    end

    def complete_action
      ship.update!(action: nil, target: nil)
    end
  end
end
