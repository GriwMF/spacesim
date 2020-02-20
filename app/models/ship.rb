class Ship < ApplicationRecord
  include HasGoods
  include HasPositionVector
  include ResourceDistributor

  belongs_to :solar_system, optional: true
  belongs_to :celestial_object, optional: true
  belongs_to :production, optional: true # target for commerce

  has_many :characters, as: :base
  has_many :bays, dependent: :destroy
  has_many :action_tables, dependent: :destroy

  def control_bay
    bays.find_by!(name: 'control')
  end

  def step # fly
    bays.find_each(&:step)
    # return set_target unless action # set ship action. Temporary here
    # return unless fly
    #
    # if arrived?
    #   update!(fly: false)
    #   History.create!(object: self, action: :arrived, params: { target: target })
    #
    #   # most likely personell should do it, but for now it's automatically
    #   send "process_#{action}"
    # else
    #   fly_to_target
    # end
    process_action || create_new_action
  end

  def arrived?
    #distance_to(target) <= WorldDatum::ARRIVED_DISTANCE
    action_tables.empty?
  end

  def trade_target
    check_stocks || find_material_to_buy
  end

  def add_credits(amount)
    amount += credits.amount
    credits.update!(amount: amount)
    History.create!(object: self, action: :add_credits, params: { credits: amount })
  end

  def fly_to(target)
    move_towards(target, calculate_speed)
    save!
  end

  private

  def process_action
    action_tables.last&.step
  end

  def create_new_action
    ('ShipActions::' + %w[Trade Explore].sample).constantize.append_to(self)
  end

  def check_stocks
    stocks.where.not(id: credits.id).each do |mat|
      production = Production.includes(:factory).where(material: mat, is_output: false).max_by(&:price)
      return production if production&.price
    end

    nil
  end

  def calculate_speed
    fuel.consume(1) ? speed * 2 : speed
  end

  def find_material_to_buy
    # TODO: unstub

    mat = Material.find_by(name: 'fuel')
    Production.includes(:factory).where(material: mat, is_output: true).min_by(&:price)
  end
end
