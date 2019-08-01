class Ship < ApplicationRecord
  include HasGoods
  include ResourceDistributor

  belongs_to :solar_system, optional: true
  belongs_to :celestial_object, optional: true
  belongs_to :production, optional: true # target for commerce

  # TODO: use to calculate distance, etc
  belongs_to :target, optional: true, polymorphic: true

  has_many :characters, as: :base
  has_many :bays, dependent: :destroy

  enum action: [:trade, :explore]

  def control_bay
    bays.find_by!(name: 'control')
  end

  def step # fly
    bays.find_each(&:step)
    return set_target unless action # set ship action. Temporary here
    return unless fly

    if progress < 100
      self.speed *= 2 if fuel.consume(1)
      update!(progress: progress + speed, speed: 0)
      History.create!(object: self, action: :flying, params: { progress: progress })
    else
      update!(fly: false)
      History.create!(object: self, action: :arrived, params: { target: target })

      # most likely personell should do it, but for now it's automatically
      process_action
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

  def process_action
    case
    when trade?
      trade_deal
    when explore?
      explore
    else
      raise 'Unknown target'
    end

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
end
