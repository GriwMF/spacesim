# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

SolarSystem.delete_all
hol = SolarSystem.create(name: 'Home of Light', x: 0, y: 100, z: 50)
cas = SolarSystem.create(name: 'Castor', x: -20, y: 10, z: 0)
eli = SolarSystem.create(name: 'Elite alpha', x: 70, y: 10, z: -10)

CelestialObject.delete_all
