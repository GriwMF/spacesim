class Production < ApplicationRecord
  belongs_to :material
  belongs_to :factory

  default_scope { includes(:material) }

  scope :input, -> { where(is_output: false) }
  scope :output, -> { where(is_output: true) }

  def price
    factory.price(self)
  end

  def factory_stock
    factory.stocks.find_by(material: material)
  end
end
