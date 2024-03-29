class Stock < ApplicationRecord
  belongs_to :material
  belongs_to :object, polymorphic: true

  def sell_all_to(target, price)
    return if amount.zero?

    requested_amount = [amount, (target.credits.amount / price).truncate].min
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

  def consume(requested_amount)
    History.create!(object: self, action: :consume, params: {
      requested_amount: requested_amount,
      done: requested_amount > amount
    })
    decrement!(:amount, requested_amount) if requested_amount > amount
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
    if buyer.is_a?(Ship)
      History.create_notification(
        buyer,
        'bought',
        { price: price, amount: requested_amount, material: material, seller: object.name }
      )
    end
    
    if object.is_a?(Ship)
      History.create_notification(
        object,
        'sold',
        { price: price, amount: requested_amount, material: material, buyer: buyer.name }
      )
    end
  end
end
