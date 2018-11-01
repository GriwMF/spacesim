class Factory < ApplicationRecord
  belongs_to :celestial_object
  has_many :productions
  has_many :stocks, as: :object

  scope :input, -> { production.where(is_output: false) }
  scope :output, -> { production.where(is_output: true) }

  def step
    input.with_lock do
      take_input_materials
      self.progress += speed
      if progress > 100
        self.progress = 0
        create_output_materials
      end
      save!
    end
  end

  def prices
    production.includes(:material).map do |p|
      material = p.material
      in_stock = stocks.find_by(material: material).amount

      # correction:
      # 0 in stock: +20%
      # for 1 production: +19%
      # for 40 and more: -20%
      excess = [in_stock / p.amount, 40].min
      correction_persent = -excess + 20
      {
          material: material,
          price: material.base_price + (material.base_price / 100.0 * correction_persent),
          for_sell: p.is_output
      }
    end
  end

  private

  def take_input_materials
    input.each do |production|
      required = production.amount
      in_stock = stocks.find_by(material_id: production.material_id)

      if in_stock.amount < required
        raise ActiveRecord::Rollback, "Not enough material for #{production}"
      end

      in_stock.update!(amount: in_stock.amount - required)
    end
  end

  def create_output_materials
    output.each do |production|
      stock = stocks.where(material_id: production.material_id).first_or_initialize
      stock.amount = stock.amount + 1
      stock.save!
    end
  end
end
