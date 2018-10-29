class AddCelestialObjectToSolarSystems < ActiveRecord::Migration[5.2]
  def change
    add_reference :solar_systems, :celestial_object, foreign_key: true
  end
end
