class Blog < ApplicationRecord
  scope :in_current_locale, -> { where(locale: I18n.locale) }
end
