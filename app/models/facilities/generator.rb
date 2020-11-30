module Facilities
  class Generator < System
    def possible_generation
      max_production * integrity / 10
    end

    def step
      update!(power: possible_generation)
      History.create!(object: self, action: :possible_generation, params: { power: power })
    end
  end
end
