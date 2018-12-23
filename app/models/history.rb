class History < ApplicationRecord
  belongs_to :object, polymorphic: true
  belongs_to :target, polymorphic: true, optional: true

  after_save do
    pp self
    ActionCable.server.broadcast("history", self.to_json)
  end
end
