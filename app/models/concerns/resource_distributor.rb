module ResourceDistributor
  extend ActiveSupport::Concern

  def generate_oxygen(amount)
    # TODO: we should order by oxygen, not max - oxygen
    distribute(amount, :max_oxygen, :oxygen)
  end

  def generate_power(amount)
    distribute(amount, :max_power, :power)
  end

  def generate_speed(amount)
    increment!(:speed, amount)
  end

  private

  # we need to distribute pressure between all bays till MAX_PRESSURE reached, starting from lowest
  def distribute(amount, max, min)
    order = "#{max} - #{min}"
    History.create!(object: self, action: :distribute, params: { amount: amount, order: order })
    loop do
      system = systems.order(Arel.sql(order)).last
      needed = system.send(max) - system.send(min)
      break if needed.zero?

      generated = [needed, amount].min
      system.increment!(min, generated)
      amount -= generated
      break if amount.zero?
    end
  end
end
