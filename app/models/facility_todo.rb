class FacilityTodo < ApplicationRecord
  belongs_to :facilities_system, class_name: 'Facilities::System'

  enum role: [:captain, :pilot, :mechanic, :gunner, :soldier]
end
