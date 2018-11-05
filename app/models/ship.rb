class Ship < ApplicationRecord
  include HasGoods
  belongs_to :solar_system, optional: true
  belongs_to :celestial_object, optional: true
  belongs_to :target, optional: true, class_name: 'Production'

  def step
    return set_target unless target

    if progress >= 100
      process_action
      self.progress = 0
      self.target = nil
    else
      self.progress += speed
      History.create!(object: self, target: target, action: :progress, params: { progress: progress })
    end
    save!
  end

  def credits
    stocks.find_or_create_by!(material: Material.find_by(name: :credit))
  end

  private

  def set_target
    update!(target: check_stocks || find_material_to_buy)
    History.create!(object: self, target: target, action: :change_target)
  end

  def process_action
    if target.is_output?
      target.factory_stock.sell_all_to(self, target.price)
    else
      stocks.find_by(material: target.material).sell_all_to(target.factory, target.price)
    end
  end

  def check_stocks
    stocks.where.not(id: credits.id).each do |mat|
      production = Production.includes(:factory).where(material: mat, is_output: false).max_by(&:price)
      return production if production&.price
    end
    nil
  end

  def find_material_to_buy
    # TODO: unstub

    mat = Material.find_by(name: 'fuel')
    Production.includes(:factory).where(material: mat, is_output: true).min_by(&:price)
  end
end
