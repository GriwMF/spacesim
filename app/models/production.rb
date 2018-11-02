class Production < ApplicationRecord
  belongs_to :material
  belongs_to :factory

  default_scope { includes(:material) }

  def price
    factory.price(self)
  end
end
