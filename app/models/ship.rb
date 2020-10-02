class Ship < ApplicationRecord
  include HasGoods
  include HasPositionVector
  include ResourceDistributor

  belongs_to :solar_system, optional: true
  belongs_to :celestial_object, optional: true
  belongs_to :production, optional: true # target for commerce

  has_many :characters, as: :base
  has_many :systems, dependent: :destroy, class_name: "Facilities::System"
  has_many :action_tables, dependent: :destroy

  def take_damage(damage)
    History.create!(object: self, action: :damage, params: { integrity: integrity, damage: damage })
    if integrity > damage
      decrement!(:integrity, damage)
    else
      History.create!(object: self, action: :system_destroy)
      destroy!
    end
  end

  def step
    systems.find_each(&:step)

    characters.find_each(&:step)
    # process_action should be done by character in control room
    # no new action for debug
    # process_action # || create_new_action
  end

  def trade_target
    check_stocks || find_material_to_buy
  end

  def add_credits(amount)
    credits.update!(amount: amount + credits.amount)
    History.create!(object: self, action: :add_credits, params: { credits: amount, total: amount + credits.amount })
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
