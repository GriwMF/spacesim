class Ship < ApplicationRecord
  include HasGoods
  include HasPositionVector
  include ResourceDistributor

  default_scope { where(killed: false) }

  belongs_to :solar_system, optional: true
  belongs_to :celestial_object, optional: true
  belongs_to :production, optional: true # target for commerce

  has_many :characters, as: :base
  has_many :systems, dependent: :destroy, class_name: "Facilities::System"
  has_many :action_tables, dependent: :destroy

  # TODO: on killed nullify action table
  def self.broadcast_ships_info
    ActionCable.server.broadcast("ship", ActiveModelSerializers::SerializableResource.new(Ship.all).as_json)
  end

  def shield
    systems.find_by(type: 'Facilities::Shield')
  end

  def take_damage(damage)
    History.create!(object: self, action: :take_damage, params: { integrity: integrity, damage: damage })
    if integrity > damage
      decrement!(:integrity, damage)
    else
      History.create!(object: self, action: :system_destroy)
      update!(killed: true)
    end
  end

  def step
    systems.find_each(&:step)

    characters.find_each(&:step)
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
