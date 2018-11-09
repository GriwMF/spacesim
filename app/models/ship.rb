class Ship < ApplicationRecord
  include HasGoods

  belongs_to :solar_system, optional: true
  belongs_to :celestial_object, optional: true
  belongs_to :production, optional: true # target for commerce

  def step
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
      update!(progress: progress + speed)
      History.create!(object: self, action: :flying, params: { progress: progress })
    else
      History.create!(object: self, action: :arrived)
    end
  end

  private

  def check_stocks
    stocks.where.not(id: credits.id).each do |mat|
      production = Production.includes(:factory).where(material: mat, is_output: false).max_by(&:price)
      return production if production&.price
    end

    nil
  end

  def arrived?
    progress >= 100
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
