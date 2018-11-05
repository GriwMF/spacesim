class Stock < ApplicationRecord
  belongs_to :material
  belongs_to :object, polymorphic: true

  def sell_all_to(target, price)
    return if amount.zero?

    requested_amount = [amount, (target.credits.amount / (price * amount)).round].min
    sell(target, requested_amount, price)
  end

  def sell(buyer, requested_amount, price)
    with_lock do
      return if amount < requested_amount

      find_stocks_with_lock(buyer)
      raise 'not enough credits' if @buyer_credits.amount < requested_amount * price

      process_sell(requested_amount, price)
      log_sell(buyer, requested_amount, price)
    end
  end

  private

  def find_stocks_with_lock(buyer)
    @buyer_stock = Stock.where(object: buyer, material: material).first_or_initialize.lock!
    @buyer_credits = buyer.credits.lock!
    @credits = object.credits.lock!
  end

  def process_sell(requested_amount, price)
    @buyer_credits.update!(amount: @buyer_credits.amount - requested_amount * price)
    @credits.update!(amount: @credits.amount + requested_amount * price)
    @buyer_stock.update!(amount: @buyer_stock.amount + requested_amount)
    update!(amount: amount - requested_amount)
  end

  def log_sell(buyer, requested_amount, price)
    History.create!(
      object: object,
      target: buyer,
      action: 'sell',
      params: { price: price, amount: requested_amount, material: material }
    )
  end
end
