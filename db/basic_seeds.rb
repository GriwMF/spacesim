def create_ship
  ship = Ship.create!(name: Faker::Games::ElderScrolls.unique.name, position_x: 0, position_y: 0, position_z: 0)

  ship.stocks.create!(material: @fuel, amount: 5)

  # ship.bays.create!(name: 'control', max_power: 2, max_oxygen: 5, control: true)
  # engine_bay = ship.bays.create!(name: 'engine', max_power: 20, max_oxygen: 5)
  # tech_bay = ship.bays.create!(name: 'tech', max_power: 20, max_oxygen: 5)
  # weapon_bay = ship.bays.create!(name: 'weapon', max_power: 40, max_oxygen: 5)

  control_bay = Facilities::ControlRoom.create!(ship: ship, max_production: 5, consumption: 1, max_power: 20, max_oxygen: 5, power: 10)
  Facilities::Engine.create!(ship: ship, max_production: 5, consumption: 1, max_power: 20, max_oxygen: 5, power: 10)
  Facilities::O2Gen.create!(ship: ship, max_production: 5, consumption: 1, max_power: 20, max_oxygen: 5, power: 10)
  Facilities::Generator.create!(ship: ship, max_production: 5, consumption: 1, max_power: 20, max_oxygen: 5, power: 10)
  Facilities::Accumulator.create!(ship: ship, max_power: 20)
  Facilities::Shield.create!(ship: ship, absorption: 100, efficiency: 100)

  Facilities::LaserBay.create!(ship: ship, consumption: 3, params: { shot_damage: 20 }, max_power: 20, max_oxygen: 5, power: 10)
  Facilities::LaserBay.create!(ship: ship, consumption: 3, params: { shot_damage: 20 }, max_power: 20, max_oxygen: 5, power: 10)

  captain = Character.create!(name: Faker.name, base: ship, location: control_bay)
end

def create_fight_objects
  2.times { create_ship }
  ShipActions::Fight.append_to(Ship.first)
  ShipActions::Fight.append_to(Ship.last)
end

def create_defaults
  sun_p1 = CelestialObject.create!(name: 'Earth', position_x: 1000, position_y: 1000, position_z: 1000)
  sun_p2 = CelestialObject.create!(name: 'Mercury', position_x: -1000, position_y: 100, position_z: 100)
  sun_p3 = CelestialObject.create!(name: 'Venus', position_x: 0, position_y: -100, position_z: -1000)
  castor_p1 = CelestialObject.create!(name: 'Calibre', position_x: -1000, position_y: -1000, position_z: -1000)

  fuel_factory = Factory.create!(name: 'Gas alpha', altitude: 5, celestial_object: sun_p3, speed: 51)
  matery_factory = Factory.create!(name: 'Einstein', altitude: 5, celestial_object: sun_p2, speed: 10)
  construction_factory = Factory.create!(name: 'Wrench', altitude: 30, celestial_object: sun_p1, speed: 3)

  fuel_factory.productions.create!(is_output: true, amount: 1, material: @fuel)
  matery_factory.productions.create!(is_output: true, amount: 1, material: @titan)
  matery_factory.productions.create!(is_output: false, amount: 10, material: @fuel)

  ship = Ship.create!(position_x: 0, position_y: 0, position_z: 0)

  ship.stocks.create!(material: @credit, amount: 200)
  ship.stocks.create!(material: @fuel, amount: 5)

  ship.bays.create!(name: 'control', max_power: 2, max_oxygen: 5, control: true)
  engine_bay = ship.bays.create!(name: 'engine', max_power: 20, max_oxygen: 5)
  tech_bay = ship.bays.create!(name: 'tech', max_power: 20, max_oxygen: 5)

  Facilities::Engine.create!(bay: engine_bay, max_production: 5, consumption: 1)
  Facilities::O2Gen.create!(bay: tech_bay, max_production: 5, consumption: 1)
  Facilities::Generator.create!(bay: tech_bay, max_production: 5, consumption: 1)

  captain1 = Character.create!(name: Faker.name, base: ship, location: ship.control_bay)
end
