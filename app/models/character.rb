class Character < ApplicationRecord
  belongs_to :base, polymorphic: true
  has_many :skills

  # has corresponding skills with same names
  enum role: [:captain, :pilot, :mechanic, :soldier]
  enum skip_reason: [:sleeping]

  before_save :clamp_attributes

  validates :skip, numericality: { greater_than_or_equal_to: 0 }

  accepts_nested_attributes_for :skills

  def step
    # TODO: here should go oxygen check as temporary stub for atmospheric

    return unless ability_to_move

    return base.set_target unless base.action

    # should be moved to ship so responsible personel like trader/scientists can process job
    if base.arrived?
      base.process_action
      hire(target.characters.where.not(role: 'captain')) if rand(2).zero? && target.is_a?(Factory)
    else
      # casual events
      Actions::Base.new(self).do_action
    end
  end

  def self.generate_character
    obj = create!(name: Faker.name, skills: { skill: role.values.sample, value: Random.rand(10) })
    History.create!(object: obj, action: :generate_character)
  end

  private

  def ability_to_move
    return suicide if hunger == 100

    continuing = true

    every(5) { self.hunger += 1 }
    every(10) { self.fatigue += 1 }

    self.fatigue -= 3 if skip_reason == 'sleeping'

    unless skip.zero?
      self.skip -= 1
      continuing = false
    end

    if fatigue == 100
      self.skip_reason = 'sleeping'
      self.skip = 5
      continuing = false
    end

    continuing = false unless base.control_bay.consume(:o2, 1) # TODO: add more logic on no oxygen and base handling

    save!
    continuing
  end

  def suicide
    destroy!
    History.create!(object: self, action: :starved)
    false
  end

  def clamp_attributes
    self.hunger = hunger.clamp(0, 100)
    self.fatigue = fatigue.clamp(0, 100)
  end

  def hire(characters)
    characters.sample&.update!(base: base)
  end
end
