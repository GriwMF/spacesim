class Character < ApplicationRecord
  belongs_to :location, polymorphic: true
  belongs_to :base, polymorphic: true
  belongs_to :facility_todo, optional: true
  has_many :skills

  # has corresponding skills with same names
  enum role: [:captain, :pilot, :mechanic, :gunner, :soldier]
  enum skip_reason: [:sleeping]

  before_save :clamp_attributes

  validates :skip, numericality: { greater_than_or_equal_to: 0 }

  accepts_nested_attributes_for :skills

  def step
    ability_to_move = true # temporary save this for history

    History.create!(object: self, action: :step, params: {
                      ability_to_move: ability_to_move,
                      location: location,
                      # base_action: base.action,
                      # base_arrived: base.arrived?
                    })

    # TODO: here should go oxygen check as temporary stub for atmospheric
    return unless ability_to_move

    # hire new personel on base
    # if base.arrived?
    #   History.create!(object: self, action: :process_action_idle, params: { base: base })
    #   hire(target.characters.where.not(role: 'captain')) if rand(2).zero? && target.is_a?(Factory)
    # end

    # casual events
    CharacterActions::Base.new(self).do
  end

  def capable_jobs

  end

  def self.generate_character(base)
    obj = create!(name: Faker.name, base: base, location: base, skills_attributes: [
                    { skill: Character.roles.keys.sample, value: Random.rand(10) }
                  ])
    History.create!(object: obj, action: :generate_character)
  end

  private

  def move
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

    continuing = false unless location.consume(:oxygen, 1) # TODO: add more logic on no oxygen and base handling

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
    char = characters.sample
    char&.update!(base: base) # should arrive to special bay?
    History.create!(object: self, action: :hire, params: { character: char })
  end
end
