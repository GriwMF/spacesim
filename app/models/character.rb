# probably use STI here to have different roles like captain etc.
class Character < ApplicationRecord
  belongs_to :ship

  enum action: [:trade, :explore]

  def step
    # TODO: first should go emergency tasks
    return set_target unless target

    if ship.arrived?
      process_action
      ship.update!(production: nil)
    else
      # casual events
      Actions::Base.new(self).do_action
    end
  end

  private

  def set_target
    update!(target: Random.rand(2))
    ship.update!(production: ship.check_stocks || find_material_to_buy, progress: 0) if trade?
    History.create!(object: self, action: :set_target, params: { production: ship.production, target: target })
  end

  def process_action
    case
    when trade?
      ship.trade_deal
    when explore?
      ship.explore
    else
      raise 'Unknown target'
    end
  end

  def find_material_to_buy
    # TODO: unstub

    mat = Material.find_by(name: 'fuel')
    Production.includes(:factory).where(material: mat, is_output: true).min_by(&:price)
  end
end
