class Factory < ApplicationRecord
  include HasGoods

  belongs_to :celestial_object
  has_many :productions
  has_many :characters, as: :base

  delegate :position_vector, to: :celestial_object

  def step
    characters.generate_character(self) if Random.rand(100).zero?

    transaction do
      take_materials_or_rollback
      self.progress += speed
      History.create!(object: self, action: :progress, params: { progress: progress })
      if progress >= 100
        self.progress = 0
        create_output_materials
      end
      save!
    end
  end

  def price(production)
    material = production.material
    in_stock = stocks.find_by(material: material)&.amount || 0

    # correction:
    # 0 in stock: +20%
    # for 1 production: +19%
    # for 40 and more: -20%
    excess = [in_stock / production.amount, 40].min
    correction_persent = -excess + 20

    material.base_price + (material.base_price / 100.0 * correction_persent)
  end

  private

  def take_materials_or_rollback
    productions.input.each do |production|
      required = production.amount
      in_stock = stocks.find_by(material_id: production.material_id)&.lock!

      if !in_stock || in_stock.amount < required
        raise ActiveRecord::Rollback, "Not enough material for #{production}"
      end

      in_stock.update!(amount: in_stock.amount - required)
      History.create!(object: self, target: production, action: :got_material)
    end
  end

  def create_output_materials
    productions.output.each do |production|
      stock = stocks.where(material_id: production.material_id).first_or_initialize.lock!
      stock.amount = stock.amount + 1
      stock.save!
      History.create!(object: self, target: production, action: :produced_material, params: { amount: stock.amount })
    end
  end
end
