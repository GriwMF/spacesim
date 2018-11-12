class Skill < ApplicationRecord
  belongs_to :character

  enum skill: [:captain, :pilot, :mechanic, :soldier]
end
