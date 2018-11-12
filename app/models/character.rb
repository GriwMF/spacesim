# probably use STI here to have different roles like captain etc.
class Character < ApplicationRecord
  belongs_to :base, polymorphic: true
  has_many :skills

  accepts_nested_attributes_for :skills

  # has corresponding skills with same names
  enum role: [:captain, :pilot, :mechanic, :soldier]

  before_save :clamp_attributes

  def step
    process_essential_events

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
    create!(name: Faker.name, skills: { skill: role.values.sample, value: Random.rand(10) })
  end

  private

  def process_essential_events
    every(5) { self.hunger -= 1 }
    every(10) { self.fatigue -= 1 }
    save!
  end

  def clamp_attributes
    self.hunger = hunger.clamp(0, 100)
    self.fatigue = fatigue.clamp(0, 100)
  end
end
