module ResourceDistributor
  extend ActiveSupport::Concern

  def generate_o2(amount)
    # we need to distribute pressure between all bays till MAX_PRESSURE reached starting from lowest
    loop do
      bay = bays.order(Arel.sql("#{Bay::MAX_PRESSURE} - pressure")).last
      break if bay.pressure == Bay::MAX_PRESSURE
      needed_pressure = Bay::MAX_PRESSURE - bay.pressure
      generated = [needed_pressure, amount].min
      bay.increment!(:pressure, generated)
      amount -= generated
      break if amount == 0
    end
  end

  def generate_power(amount)
    generate(Arel.sql('max_power - power'), amount, ->{ bay.pressure }, ->{})
    bay = bays.order(Arel.sql('max_power - power')).last
    bay.update!(power: bay.power + amount)

    loop do
      bay = bays.order(Arel.sql('max_power - power')).last
      break if bay.max_power == bay.power
      needed = bay.max_power - bay.power
      generated = [needed, amount].min
      bay.increment!(:power, generated)
      amount -= generated
      break if amount == 0
    end
  end

  def consume_o2(resource, amount)
    decrement!(resource, amount) if send(:resource) >= amount
  end

  def consume_power(resource, amount)
    decrement!(resource, amount) if send(:resource) >= amount
  end

  private

  def generate(order, amount, max, min)
    loop do
      bay = bays.order(Arel.sql('max_power - power')).last
      break if bay.max_power == bay.power
      needed = bay.max_power - bay.power
      generated = [needed, amount].min
      bay.increment!(:power, generated)
      amount -= generated
      break if amount == 0
    end
  end
end
