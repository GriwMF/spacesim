# probably use STI here to have different roles like captain etc.
class Character < ApplicationRecord
  belongs_to :base, polymorphic: true

  enum position: [:captain, :pilot, :mechanic, :soldier]

  def step
    # TODO: first should go emergency tasks
    return base.set_target unless base.action

    # should be moved to ship so responsible personel like trader/scientists can process job
    if base.arrived?
      base.process_action
    else
      # casual events
      Actions::Base.new(self).do_action
    end
  end

  def self.generate_character
    create!(name: Faker.name, skill: Random.rand(10), position: positions.values.sample)
  end
end
