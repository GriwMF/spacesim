module ResourceDistributor
  extend ActiveSupport::Concern

  def generate_oxygen(amount)
    # TODO: we should order by oxygen, not max - oxygen
    generate(amount, 'max_oxygen - oxygen', :max_oxygen, :oxygen)
  end

  def generate_power(amount)
    generate(amount, 'max_power - power', :max_power, :power)
  end

  def generate_speed(amount)
    increment!(:speed, amount)
  end

  private

  # we need to distribute pressure between all bays till MAX_PRESSURE reached, starting from lowest
  def generate(amount, order, max, min)
    loop do
      bay = bays.order(Arel.sql(order)).last
      needed = bay.send(max) - bay.send(min)
      break if needed.zero?

      generated = [needed, amount].min
      bay.increment!(min, generated)
      amount -= generated
      break if amount.zero?
    end
  end
end
