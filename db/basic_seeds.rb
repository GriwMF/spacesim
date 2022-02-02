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
  Facilities::Dormitory.create!(ship: ship, max_production: 5, consumption: 1, max_power: 20, max_oxygen: 5, power: 10)

  Facilities::LaserBay.create!(ship: ship, consumption: 3, params: { shot_damage: 20 }, max_power: 20, max_oxygen: 5, power: 10)
  Facilities::LaserBay.create!(ship: ship, consumption: 3, params: { shot_damage: 20 }, max_power: 20, max_oxygen: 5, power: 10)

  captain = Character.create!(name: Faker.name, base: ship, location: control_bay)
end

def create_fight_objects
  2.times { create_ship }
  ShipActions::Fight.append_to(Ship.first, enemy: Ship.last)
  ShipActions::Fight.append_to(Ship.last, enemy: Ship.first)
end

def create_traders
  2.times { create_ship }
end

def create_defaults
  sun_p1 = CelestialObject.create!(name: 'Earth', position_x: 1000, position_y: 1000, position_z: 1000)
  sun_p2 = CelestialObject.create!(name: 'Mercury', position_x: -1000, position_y: 100, position_z: 100)
  sun_p3 = CelestialObject.create!(name: 'Venus', position_x: 0, position_y: -100, position_z: -1000)
  castor_p1 = CelestialObject.create!(name: 'Calibre', position_x: -1000, position_y: -1000, position_z: -1000)

  fuel_factory = Factory.create!(name: 'Gas alpha', speed: 50, position_x: 1, position_y: 1, position_z: 1)
  matery_factory = Factory.create!(name: 'Einstein', speed: 50, position_x: 5, position_y: 0, position_z: 0)
  construction_factory = Factory.create!(name: 'Wrench', speed: 50, position_x: 1, position_y: 4, position_z: -2)

  fuel_factory.productions.create!(is_output: true, amount: 1, material: @fuel)
  fuel_factory.fuel.update(amount: 100)
  matery_factory.productions.create!(is_output: true, amount: 1, material: @titan)
  matery_factory.productions.create!(is_output: false, amount: 10, material: @fuel)

  ship = Ship.create!(name: 'rabbit', position_x: 0, position_y: 0, position_z: 0)

  ship.stocks.create!(material: @credit, amount: 200)
  ship.stocks.create!(material: @fuel, amount: 5)

  control_bay = Facilities::ControlRoom.create!(ship: ship, max_production: 5, consumption: 1, max_power: 20, max_oxygen: 5, power: 10)
  Facilities::Engine.create!(ship: ship, max_production: 5, consumption: 1, max_power: 20, max_oxygen: 5, power: 10)
  Facilities::O2Gen.create!(ship: ship, max_production: 5, consumption: 1, max_power: 20, max_oxygen: 5, power: 10)
  Facilities::Generator.create!(ship: ship, max_production: 5, consumption: 1, max_power: 20, max_oxygen: 5, power: 10)

  # captain1 = Character.create!(name: Faker.name, base: ship, location: ship.control_bay)
end
