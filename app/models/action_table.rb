class ActionTable < ApplicationRecord
  include ParamsSerialization

  belongs_to :ship

  default_scope { order(:priority) }

  before_create do
    self.priority = ActionTable.where(ship: ship).maximum(:priority) || 0
    self.priority += 1
  end

  def step(character)
    action = action_type.constantize.new(ship, params)

    if action.step(character)
      update!(params: action.dump)
    else
      destroy!
    end
  end

  def self.create_new_basic_action
    #should set up random action

    # @ship.action = Random.rand(2)
    # @ship.fly = true
    # @ship.progress = 0
    # if @ship.trade?
    #   @ship.production = @ship.check_stocks || @ship.find_material_to_buy
    #   @ship.target = @ship.production.factory
    # else
    #   @ship.target = CelestialObject.sample
    # end
    #
    # @ship.save!
    # History.create!(object: @ship, action: :set_target, params: { production: @ship.production, target: @ship.target, action: @ship.action })
  end
end
