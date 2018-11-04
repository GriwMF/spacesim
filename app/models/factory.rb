class Factory < ApplicationRecord
  belongs_to :celestial_object
  has_many :productions
  has_many :stocks, as: :object


  def credits
    stocks.find_or_create_by!(material: Material.find_by(name: :credit))
  end

  def step
    transaction do
      take_input_materials
      self.progress += speed
      if progress >= 100
        self.progress = 0
        create_output_materials
      end
      save!
    end
  end

  def price(production)
    material = production.material
    in_stock = stocks.find_by(material: material).amount

    # correction:
    # 0 in stock: +20%
    # for 1 production: +19%
    # for 40 and more: -20%
    excess = [in_stock / production.amount, 40].min
    correction_persent = -excess + 20

    material.base_price + (material.base_price / 100.0 * correction_persent)
  end

  private

  def take_input_materials
    productions.input.each do |production|
      production.lock!
      required = production.amount
      in_stock = stocks.find_by(material_id: production.material_id)

      if in_stock.amount < required
        raise ActiveRecord::Rollback, "Not enough material for #{production}"
      end

      in_stock.update!(amount: in_stock.amount - required)
    end
  end

  def create_output_materials
    productions.output.each do |production|
      stock = stocks.where(material_id: production.material_id).first_or_initialize
      stock.amount = stock.amount + 1
      stock.save!
    end
  end
end
