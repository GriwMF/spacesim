module ResourceDistributor
  extend ActiveSupport::Concern

  def generate_oxygen(amount)
    # TODO: we should order by oxygen, not max - oxygen
    distribute(amount, :max_oxygen, :oxygen)
  end

  def generate_speed(amount)
    increment!(:speed, amount)
  end

  def consume_power(amount)
    power_systems = systems.where(type: ['Facilities::Generator', 'Facilities::Accumulator'])
    power = power_systems.sum(:power)
    amount_left = amount
    if amount <= power
      power_systems.each do |system|
        consume = [amount_left, system.power].min
        system.decrement!(:power, consume)
        amount_left -= consume
      end
    end
  end

  def consume_power_upto(amount, accum_included = false)
    not_consumed = amount

    type = 'Facilities::Generator'
    type = [type, 'Facilities::Accumulator'] if accum_included

    systems.where(type: 'Facilities::Generator').each do |gen|
      not_consumed -= gen.consume_upto(not_consumed)
    end
    amount - not_consumed
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
