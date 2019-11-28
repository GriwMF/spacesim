class User < ApplicationRecord
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create },
                    presence: true,
                    uniqueness: true
  mailkick_user
  has_secure_password
end
