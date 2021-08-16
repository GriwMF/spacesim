module Facilities
  class ControlRoom < System
    def step
      # control ship
      #
      #     # process_action should be done by character in control room
      #     # no new action for debug
      # probably the best is to do process_action everytime and create_new_action only if captain / pilot is present
      # create_new_action disabled for only - fight demo
      process_action # || create_new_action
      # @character.location.ship.action_tables.last&.step(@character)
    end

    def navigate

    end

    private

    def process_action
      ship.action_tables.last&.step
    end

    def create_new_action
      "ShipActions::#{%w[Trade Explore].sample}".constantize.append_to(ship)
    end

  end
end
