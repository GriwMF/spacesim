class FacilityTodo < ApplicationRecord
  belongs_to :system,
             class_name: 'Facilities::System',
             foreign_key: :facilities_system_id
  has_many :characters

  enum role: [:captain, :pilot, :mechanic, :gunner, :soldier]
end
