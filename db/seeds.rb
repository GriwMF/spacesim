# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Material.delete_all
Material.create(name: 'fuel')
Material.create(name: 'titan')
Material.create(name: 'weapon components')

CelestialObject.delete_all
sun = CelestialObject.create!(name: 'Sun')
sun_castor = CelestialObject.create!(name: 'Castor')
sun_century = CelestialObject.create!(name: 'Century')

sun_p1 = CelestialObject.create!(name: 'Earth', altitude: 250, parent_object: sun)
sun_p2 = CelestialObject.create!(name: 'Mercury', altitude: 400, parent_object: sun)
sun_p3 = CelestialObject.create!(name: 'Venus', altitude: 120, parent_object: sun)
castor_p1 = CelestialObject.create!(name: 'Calibre', altitude: 500, parent_object: sun_castor)

Factory.delete_all
Production.delete_all
Material.delete_all

fuel = Material.create(name: 'fuel', weigth: 1, is_output: true)

fuel_factory = Factory.new(name: 'Gas alpha', altitude: 5, parent_object: sun_p3, step_progress: 51)
matery_factory = Factory.new(name: 'Einstein', altitude: 5, parent_object: sun_p2)
construction_factory = Factory.new(name: 'Wrench', altitude: 30, parent_object: sun_p1)

fuel_factory.productions.create(type: :output, amount: 1, time: 10, material: fuel)
SolarSystem.delete_all
hol = SolarSystem.create(name: 'Home of Light', celestial_object: sun, x: 0, y: 100, z: 50)
cas = SolarSystem.create(name: 'Castor', x: -20, celestial_object: sun_castor, y: 10, z: 0)
eli = SolarSystem.create(name: 'Elite alpha', celestial_object: sun_century, x: 70, y: 10, z: -10)


