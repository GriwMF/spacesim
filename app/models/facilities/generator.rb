module Facilities
  class Generator < System
    def possible_generation
      max_production * integrity / 100
    end

    def step
      update!(power: possible_generation)
    end

    def consume_upto(amount)
      consumed = [amount, power].min
      decrement!(:power, consumed)
      consumed
    end
  end
end
