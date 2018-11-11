# probably use STI here to have different roles like captain etc.
class Character < ApplicationRecord
  belongs_to :ship

  def step
    # TODO: first should go emergency tasks
    return ship.set_target unless ship.action

    if ship.arrived?
      ship.process_action
    else
      # casual events
      Actions::Base.new(self).do_action
    end
  end

  private

end
