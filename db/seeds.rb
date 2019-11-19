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
CelestialObject.delete_all
Character.delete_all
Facilities::System.delete_all
Bay.delete_all
Ship.delete_all

WorldDatum.create!(key: :step, value: 0)

fuel = Material.create!(name: 'fuel', weigth: 1, base_price: 31)
titan = Material.create!(name: 'titan', weigth: 100, base_price: 500)
Material.create!(name: 'weapon components', weigth: 80, base_price: 2000)
credit = Material.create!(name: 'credit', weigth: 0, base_price: 1)


sun_p1 = CelestialObject.create!(name: 'Earth', position_x: 1000, position_y: 1000, position_z: 1000)
sun_p2 = CelestialObject.create!(name: 'Mercury', position_x: -1000, position_y: 100, position_z: 100)
sun_p3 = CelestialObject.create!(name: 'Venus', position_x: 0, position_y: -100, position_z: -1000)
castor_p1 = CelestialObject.create!(name: 'Calibre', position_x: -1000, position_y: -1000, position_z: -1000)



fuel_factory = Factory.create!(name: 'Gas alpha', altitude: 5, celestial_object: sun_p3, speed: 51)
matery_factory = Factory.create!(name: 'Einstein', altitude: 5, celestial_object: sun_p2, speed: 10)
construction_factory = Factory.create!(name: 'Wrench', altitude: 30, celestial_object: sun_p1, speed: 3)

fuel_factory.productions.create!(is_output: true, amount: 1, material: fuel)
matery_factory.productions.create!(is_output: true, amount: 1, material: titan)
matery_factory.productions.create!(is_output: false, amount: 10, material: fuel)

ship = Ship.create!(position_x: 0, position_y: 0, position_z: 0)

ship.stocks.create!(material: credit, amount: 200)
ship.stocks.create!(material: fuel, amount: 5)

ship.bays.create!(name: 'control', max_power: 2, max_oxygen: 5, control: true)
engine_bay = ship.bays.create!(name: 'engine', max_power: 20, max_oxygen: 5)
tech_bay = ship.bays.create!(name: 'tech', max_power: 20, max_oxygen: 5)

Facilities::Engine.create!(bay: engine_bay, max_production: 5, consumption: 1)
Facilities::O2Gen.create!(bay: tech_bay, max_production: 5, consumption: 1)
Facilities::Generator.create!(bay: tech_bay, max_production: 5, consumption: 1)

captain1 = Character.create!(name: Faker.name, base: ship, location: ship.control_bay)
