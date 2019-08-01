module ShipTasks
  class Explore < Processor
    def step
      amount = ship.credits.amount + 10
      ship.credits.update!(amount: amount)
      History.create!(object: ship, action: :explore, params: { credits: amount })
    end
  end
end
