class Ship < ApplicationRecord
  include HasGoods

  belongs_to :solar_system, optional: true
  belongs_to :celestial_object, optional: true
  belongs_to :production, optional: true # target for commerce

  # TODO: use to calculate distance, etc
  belongs_to :target, optional: true, polymorphic: true

  has_many :characters, as: :base

  enum action: [:trade, :explore]

  def step # fly
    return unless fly
    # return set_target unless target
    #
    # if progress >= 100
    #   process_action
    #   self.progress = 0
    #   self.target = nil
    # else
    #   self.progress += speed
    #   History.create!(object: self, action: :progress,
    #                   params: { progress: progress, production: production, target: target })
    # end
    #
    # save!
    if progress < 100
      update!(progress: progress + speed + bonus_speed, bonus_speed: 0)
      History.create!(object: self, action: :flying, params: { progress: progress })
    else
      update!(fly: false)
      History.create!(object: self, action: :arrived, params: { target: target })
    end
  end

  def set_target
    self.action = Random.rand(2)
    self.fly = true
    self.progress = 0
    if trade?
      self.production = check_stocks || find_material_to_buy
      self.target = production.target
    else
      self.target = CelestialObject.sample
    end
    save!
    History.create!(object: self, action: :set_target, params: { production: production, action: action, by: characters.take })
  end

  def process_action
    case
    when trade?
      trade_deal
    when explore?
      explore
    else
      raise 'Unknown target'
    end

    update!(action: nil, production: nil)
  end

  def arrived?
    progress >= 100
  end

  private

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

  def explore
    amount = credits.amount + 10
    credits.update!(amount: amount)
    History.create!(object: self, action: :explore, params: { credits: amount })
  end

  def trade_deal
    if production.is_output?
      production.factory_stock.sell_all_to(self, production.price)
    else
      stocks.find_by(material: production.material).sell_all_to(production.factory, production.price)
    end
  end
end
