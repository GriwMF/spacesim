class FacilityTodo < ApplicationRecord
  belongs_to :facilities_system, class_name: 'Facilities::System'
  has_many :characters, foreign_key: :facility_todos_id

  enum role: [:captain, :pilot, :mechanic, :gunner, :soldier]
end
