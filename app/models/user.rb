class User < ApplicationRecord
  has_secure_password validations: false
  mailkick_user

  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create },
                    presence: true,
                    uniqueness: true
end
