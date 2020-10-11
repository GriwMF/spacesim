class Material < ApplicationRecord
  has_many :stocks
  has_many :productions

  def self.credit
    @credit ||= find_by(name: :credit)
  end

  def self.fuel
    @fuel ||= find_by(name: :fuel)
  end
end
