class History < ApplicationRecord
  belongs_to :object, polymorphic: true

  after_save do
    ActionCable.server.broadcast("history", self.to_json)
  end
end
