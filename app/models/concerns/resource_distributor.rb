module ResourceDistributor
  extend ActiveSupport::Concern

  def generate_o2(amount)
    generate(amount, "#{Bay::MAX_PRESSURE} - pressure", :max_pressure, :pressure)
  end

  def generate_power(amount)
    generate(amount, 'max_power - power', :max_power, :power)
  end

  private

  # we need to distribute pressure between all bays till MAX_PRESSURE reached starting from lowest
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
