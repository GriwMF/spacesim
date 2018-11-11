class History < ApplicationRecord
  belongs_to :object, polymorphic: true
  belongs_to :target, polymorphic: true, optional: true

  before_save do
    pp self
  end
end
