class Ship < ApplicationRecord
  include HasGoods
  include HasPositionVector
  include ResourceDistributor

  belongs_to :solar_system, optional: true
  belongs_to :celestial_object, optional: true
  belongs_to :production, optional: true # target for commerce

  # TODO: use to calculate distance, etc
  belongs_to :target, optional: true, polymorphic: true

  has_many :characters, as: :base
  has_many :bays, dependent: :destroy

  enum action: [:trade, :exploration]

  def control_bay
    bays.find_by!(name: 'control')
  end

  def step # fly
    bays.find_each(&:step)
    return set_target unless action # set ship action. Temporary here
    return unless fly

    if arrived?
      update!(fly: false)
      History.create!(object: self, action: :arrived, params: { target: target })

      # most likely personell should do it, but for now it's automatically
      send "process_#{action}"
    else
      fly_to_target
    end
  end

  def set_target
    self.action = Random.rand(2)
    self.fly = true
    self.progress = 0
    if trade?
      self.production = check_stocks || find_material_to_buy
      self.target = production.factory
    else
      self.target = CelestialObject.sample
    end

    save!
    History.create!(object: self, action: :set_target, params: { production: production, target: target, action: action, by: characters.take })
  end

  def arrived?
    distance_to(target) <= WorldDatum::ARRIVED_DISTANCE
  end

  private

  def process_exploration
    amount = credits.amount + 10
    credits.update!(amount: amount)
    History.create!(object: self, action: :exploration, params: { credits: amount })
  end

  def process_trade
    if target.is_output?
      target.factory_stock.sell_all_to(self, target.price)
    else
      ship.stocks.find_by(material: target.material).sell_all_to(target.factory, target.price)
    end
  end

  def check_stocks
    stocks.where.not(id: credits.id).each do |mat|
      production = Production.includes(:factory).where(material: mat, is_output: false).max_by(&:price)
      return production if production&.price
    end

    nil
  end

  def fly_to_target
    current_speed = speed
    current_speed *= 2 if fuel.consume(1)
    move_towards(target, current_speed)
    save!

    History.create!(object: self, action: :fly_to_target, params: { speed: current_speed, target: target })
  end

  def find_material_to_buy
    # TODO: unstub

    mat = Material.find_by(name: 'fuel')
    Production.includes(:factory).where(material: mat, is_output: true).min_by(&:price)
  end
end
