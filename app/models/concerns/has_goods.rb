module HasGoods
  extend ActiveSupport::Concern

  included do
    has_many :stocks, as: :object
  end

  def credits
    stocks.find_or_create_by!(material: Material.credit)
  end

  def fuel
    stocks.find_or_create_by!(material: Material.fuel)
  end
end
