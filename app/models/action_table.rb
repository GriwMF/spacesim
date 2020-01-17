class ActionTable < ApplicationRecord
  include ParamsSerialization

  belongs_to :ship

  before_create do
    self.priority = ActionTable.where(ship: ship).maximum(:priority) || 0
    self.priority += 1
  end

  def self.pick_base_action
    trade_action = ShipActions::Trade.new(ship, target_production: ship.check_stocks || ship.find_material_to_buy)

    create!(params: trade_action.dump, action_type: trade_action.class)
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
