# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
WorldDatum.delete_all
Production.delete_all
Stock.delete_all
Material.delete_all
Factory.delete_all
SolarSystem.delete_all
CelestialObject.delete_all
Character.delete_all
Ship.delete_all

WorldDatum.create!(key: :step)

fuel = Material.create!(name: 'fuel', weigth: 1, base_price: 31)
titan = Material.create!(name: 'titan', weigth: 100, base_price: 500)
Material.create!(name: 'weapon components', weigth: 80, base_price: 2000)
credit = Material.create!(name: 'credit', weigth: 0, base_price: 1)


sun = CelestialObject.create!(name: 'Sun')
sun_castor = CelestialObject.create!(name: 'Castor')
sun_century = CelestialObject.create!(name: 'Century')

sun_p1 = CelestialObject.create!(name: 'Earth', altitude: 250, parent_object: sun)
sun_p2 = CelestialObject.create!(name: 'Mercury', altitude: 400, parent_object: sun)
sun_p3 = CelestialObject.create!(name: 'Venus', altitude: 120, parent_object: sun)
castor_p1 = CelestialObject.create!(name: 'Calibre', altitude: 500, parent_object: sun_castor)




fuel_factory = Factory.create!(name: 'Gas alpha', altitude: 5, celestial_object: sun_p3, speed: 51)
matery_factory = Factory.create!(name: 'Einstein', altitude: 5, celestial_object: sun_p2, speed: 10)
construction_factory = Factory.create!(name: 'Wrench', altitude: 30, celestial_object: sun_p1, speed: 3)

fuel_factory.productions.create!(is_output: true, amount: 1, material: fuel)
matery_factory.productions.create!(is_output: true, amount: 1, material: titan)
matery_factory.productions.create!(is_output: false, amount: 10, material: fuel)

hol = SolarSystem.create!(name: 'Home of Light', celestial_object: sun, x: 0, y: 100, z: 50)
cas = SolarSystem.create!(name: 'Castor', celestial_object: sun_castor, y: 10, z: 0, x: -20)
eli = SolarSystem.create!(name: 'Elite alpha', celestial_object: sun_century, x: 70, y: 10, z: -10)


ship = Ship.create!(speed: 10)
ship.stocks.create!(material: credit, amount: 200)

captain1 = Character.create!(name: Faker.name, base: ship)
