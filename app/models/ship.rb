class Ship < ApplicationRecord
  has_many :stocks, as: :object
  belongs_to :solar_system, optional: true
  belongs_to :celestial_object, optional: true
  belongs_to :target, optional: true, class_name: 'CelestialObject'

  def step
    set_target unless target
    if progress > 100
      self.progress = 0
      process_action
    else
      self.progress += speed
    end
    save!
  end

  private

  def set_target
    check_stocks
    find_material_to_buy

  end

  def process_action

  end

  def check_stocks
    stocks.each do |mat|
      production = Production.includes(:factory).where(material: mat, is_output: false).max_by(&:price)
      production && return production
    end
  end

  def find_material_to_buy

  end
end
